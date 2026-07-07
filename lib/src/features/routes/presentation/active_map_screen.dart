import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/map/kos_map.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/utils/time_format.dart';
import '../../../core/widgets/components.dart';
import '../../charkhs/data/charkh_repository.dart';
import '../../charkhs/domain/charkh.dart';
import '../../locations/data/current_location_service.dart';
import '../../locations/domain/coordinates.dart';
import '../application/active_route_bloc.dart';
import '../data/active_route_repository.dart';
import '../data/directions_service.dart';

class ActiveMapScreen extends StatelessWidget {
  const ActiveMapScreen({
    super.key,
    required this.charkhStableId,
    required this.charkhRepository,
    required this.activeRouteRepository,
    required this.directionsService,
    required this.currentLocationService,
  });

  final String charkhStableId;
  final CharkhRepository charkhRepository;
  final ActiveRouteRepository activeRouteRepository;
  final DirectionsService directionsService;
  final CurrentLocationService currentLocationService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Charkh?>(
      future: charkhRepository.getCharkh(charkhStableId),
      builder: (context, snapshot) {
        final charkh = snapshot.data;
        if (charkh == null) {
          return Scaffold(
            backgroundColor: context.colors.surface,
            body: Center(
              child: Text(
                snapshot.connectionState == ConnectionState.done
                    ? 'Charkh not found'
                    : 'Loading',
              ),
            ),
          );
        }

        return BlocProvider(
          create: (_) => ActiveMapBloc(
            activeRouteRepository: activeRouteRepository,
            directionsService: directionsService,
            currentLocationService: currentLocationService,
          )..add(ActiveMapStarted(charkh)),
          child: const _ActiveMapView(),
        );
      },
    );
  }
}

class _ActiveMapView extends StatefulWidget {
  const _ActiveMapView();

  @override
  State<_ActiveMapView> createState() => _ActiveMapViewState();
}

class _ActiveMapViewState extends State<_ActiveMapView>
    with SingleTickerProviderStateMixin {
  static const _maxActiveMapZoom = 20.5;

  late final MapController _mapController;
  late final AnimationController _cameraAnimationController;

  bool _mapReady = false;
  Coordinates? _pendingCameraTarget;
  DateTime? _lastCameraFollowAt;
  ActiveMapState? _previousListenedState;
  VoidCallback? _cameraAnimationListener;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    _cameraAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _removeCameraAnimationListener();
    _cameraAnimationController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  void _handleMapReady(ActiveMapState state) {
    _mapReady = true;
    final target = _pendingCameraTarget ?? state.userLocation;
    _pendingCameraTarget = null;
    if (target != null && state.isCameraLockedToUser) {
      _animateCameraTo(
        target,
        force: true,
        targetZoom: state.preferredFollowZoom,
        targetRotation: state.smoothedCameraHeadingDegrees,
      );
    }
  }

  void _handleMapEvent(MapEvent event) {
    final bloc = context.read<ActiveMapBloc>();
    bloc.add(
      ActiveMapCameraChanged(
        zoom: event.camera.zoom,
        rotation: event.camera.rotation,
      ),
    );

    final isManualPan =
        event.source == MapEventSource.dragStart ||
        event.source == MapEventSource.onDrag;
    if (isManualPan && bloc.state.isCameraLockedToUser) {
      bloc.add(const ActiveMapCameraUnlocked());
    }
  }

  void _handleStateChanged(ActiveMapState previous, ActiveMapState current) {
    final target = current.userLocation;
    if (target == null || !current.isCameraLockedToUser) {
      return;
    }

    final relocked =
        !previous.isCameraLockedToUser && current.isCameraLockedToUser;
    final locationChanged = previous.userLocation != current.userLocation;
    final headingChanged =
        previous.smoothedCameraHeadingDegrees !=
        current.smoothedCameraHeadingDegrees;
    if (relocked || locationChanged || headingChanged) {
      _animateCameraTo(
        target,
        force: relocked,
        targetZoom: relocked ? current.preferredFollowZoom : null,
        targetRotation: current.smoothedCameraHeadingDegrees,
      );
    }
  }

  void _relockCamera(ActiveMapState state) {
    context.read<ActiveMapBloc>().add(const ActiveMapCameraLocked());
    final target = state.userLocation;
    if (target != null) {
      _animateCameraTo(
        target,
        force: true,
        targetZoom: state.preferredFollowZoom,
        targetRotation: state.smoothedCameraHeadingDegrees,
      );
    }
  }

  void _animateCameraTo(
    Coordinates target, {
    required bool force,
    double? targetZoom,
    double? targetRotation,
  }) {
    if (!_mapReady) {
      _pendingCameraTarget = target;
      return;
    }

    final now = DateTime.now();
    if (!force &&
        _lastCameraFollowAt != null &&
        now.difference(_lastCameraFollowAt!) <
            const Duration(milliseconds: 320)) {
      return;
    }

    final targetPoint = target.toLatLng();
    final currentCamera = _mapController.camera;
    final rotationTarget = targetRotation ?? currentCamera.rotation;
    const distance = Distance();
    final rotationDistance = _angleDistance(
      currentCamera.rotation,
      rotationTarget,
    );
    if (!force &&
        distance(currentCamera.center, targetPoint) < 4 &&
        rotationDistance < 1) {
      return;
    }

    _lastCameraFollowAt = now;
    _removeCameraAnimationListener();
    _cameraAnimationController.stop();
    _cameraAnimationController.duration = const Duration(milliseconds: 620);

    final centerTween = _LatLngTween(
      begin: currentCamera.center,
      end: targetPoint,
    );
    final zoomTween = Tween<double>(
      begin: currentCamera.zoom,
      end: currentCamera.clampZoom(targetZoom ?? currentCamera.zoom),
    );
    final rotationTween = _AngleTween(
      begin: currentCamera.rotation,
      end: rotationTarget,
    );
    _cameraAnimationListener = () {
      final eased = Curves.easeOutCubic.transform(
        _cameraAnimationController.value,
      );
      _mapController.moveAndRotate(
        centerTween.transform(eased),
        zoomTween.transform(eased),
        rotationTween.transform(eased),
      );
    };

    _cameraAnimationController
      ..addListener(_cameraAnimationListener!)
      ..forward(from: 0).whenCompleteOrCancel(() {
        _removeCameraAnimationListener();
      });
  }

  void _removeCameraAnimationListener() {
    final listener = _cameraAnimationListener;
    if (listener == null) {
      return;
    }
    _cameraAnimationController.removeListener(listener);
    _cameraAnimationListener = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: BlocConsumer<ActiveMapBloc, ActiveMapState>(
        listenWhen: (previous, current) {
          final shouldListen =
              previous.userLocation != current.userLocation ||
              previous.isCameraLockedToUser != current.isCameraLockedToUser ||
              previous.smoothedCameraHeadingDegrees !=
                  current.smoothedCameraHeadingDegrees;
          if (shouldListen) {
            _previousListenedState = previous;
          }
          return shouldListen;
        },
        listener: (context, state) {
          final previous = _previousListenedState ?? state;
          _handleStateChanged(previous, state);
        },
        builder: (context, state) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final sheetSize = state.isPanelExpanded
                  ? _expandedSheetSize
                  : _collapsedSheetSize;
              return Stack(
                children: [
                  KosMap(
                    points: state.route?.points ?? const [],
                    destinations: state.destinations,
                    userLocation: state.userLocation,
                    activeDestinationIndex: state.currentDestinationIndex,
                    mapController: _mapController,
                    initialZoom: state.preferredFollowZoom,
                    maxZoom: _maxActiveMapZoom,
                    enableRotation: true,
                    onMapEvent: _handleMapEvent,
                    onMapReady: () => _handleMapReady(state),
                  ),
                  if (state.status == ActiveMapStatus.loading)
                    Center(
                      child: CircularProgressIndicator(
                        color: context.colors.primary,
                      ),
                    ),
                  _CameraFollowButton(
                    isLocked: state.isCameraLockedToUser,
                    bottom: constraints.maxHeight * sheetSize + 24,
                    onPressed: () => _relockCamera(state),
                  ),
                  _RoutePanel(state: state),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _LatLngTween extends Tween<LatLng> {
  _LatLngTween({required super.begin, required super.end});

  @override
  LatLng lerp(double t) {
    final start = begin!;
    final finish = end!;
    return LatLng(
      start.latitude + (finish.latitude - start.latitude) * t,
      start.longitude + (finish.longitude - start.longitude) * t,
    );
  }
}

class _AngleTween extends Tween<double> {
  _AngleTween({required super.begin, required super.end});

  @override
  double lerp(double t) {
    final start = begin!;
    final delta = _shortestAngleDelta(start, end!);
    return _normalizeDegrees(start + delta * t);
  }
}

double _angleDistance(double from, double to) {
  return _shortestAngleDelta(from, to).abs();
}

double _shortestAngleDelta(double from, double to) {
  return ((to - from + 540) % 360) - 180;
}

double _normalizeDegrees(double degrees) {
  final normalized = degrees % 360;
  return normalized < 0 ? normalized + 360 : normalized;
}

class _CameraFollowButton extends StatelessWidget {
  const _CameraFollowButton({
    required this.isLocked,
    required this.bottom,
    required this.onPressed,
  });

  final bool isLocked;
  final double bottom;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 24,
      bottom: bottom,
      child: IconSquareButton(
        asset: KosAssets.myLocation,
        onPressed: onPressed,
        backgroundColor: isLocked
            ? context.colors.green900
            : context.colors.primary,
        iconColor: context.colors.onSurface,
      ),
    );
  }
}

const _collapsedSheetSize = 0.12;
const _expandedSheetSize = 0.31;
const _sheetSnapTolerance = 0.04;

class _RoutePanel extends StatefulWidget {
  const _RoutePanel({required this.state});

  final ActiveMapState state;

  @override
  State<_RoutePanel> createState() => _RoutePanelState();
}

class _RoutePanelState extends State<_RoutePanel> {
  late final DraggableScrollableController _controller;

  @override
  void initState() {
    super.initState();
    _controller = DraggableScrollableController();
  }

  @override
  void didUpdateWidget(covariant _RoutePanel oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.state.panelState != widget.state.panelState) {
      _animateToPanelState(widget.state.panelState);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleSheet() {
    context.read<ActiveMapBloc>().add(const ActiveMapPanelToggled());
  }

  void _animateToPanelState(ActiveMapPanelState panelState) {
    if (!_controller.isAttached) {
      return;
    }
    final target = panelState == ActiveMapPanelState.expanded
        ? _expandedSheetSize
        : _collapsedSheetSize;
    _controller.animateTo(
      target,
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOutCubic,
    );
  }

  bool _handleSheetNotification(DraggableScrollableNotification notification) {
    if (notification.extent >= _expandedSheetSize - _sheetSnapTolerance &&
        !widget.state.isPanelExpanded) {
      context.read<ActiveMapBloc>().add(const ActiveMapPanelExpanded());
    } else if (notification.extent <=
            _collapsedSheetSize + _sheetSnapTolerance &&
        widget.state.isPanelExpanded) {
      context.read<ActiveMapBloc>().add(const ActiveMapPanelCollapsed());
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return NotificationListener<DraggableScrollableNotification>(
      onNotification: _handleSheetNotification,
      child: DraggableScrollableSheet(
        controller: _controller,
        initialChildSize: _collapsedSheetSize,
        minChildSize: _collapsedSheetSize,
        maxChildSize: _expandedSheetSize,
        snap: true,
        snapSizes: const [_collapsedSheetSize, _expandedSheetSize],
        builder: (context, scrollController) {
          return Material(
            color: context.colors.surface,
            child: SingleChildScrollView(
              controller: scrollController,
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.fromLTRB(24, 8, 24, 18 + bottomInset),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _PanelHandle(onTap: _toggleSheet),
                    const SizedBox(height: 18),
                    _PanelHeader(state: widget.state),
                    AnimatedCrossFade(
                      firstChild: const SizedBox(width: double.infinity),
                      secondChild: _ExpandedPanelDetails(state: widget.state),
                      crossFadeState: widget.state.isPanelExpanded
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,
                      duration: const Duration(milliseconds: 180),
                      sizeCurve: Curves.easeOutCubic,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _PanelHandle extends StatelessWidget {
  const _PanelHandle({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          width: 132,
          height: 20,
          child: Center(
            child: Container(
              width: 112,
              height: 3,
              color: context.colors.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}

class _PanelHeader extends StatelessWidget {
  const _PanelHeader({required this.state});

  final ActiveMapState state;

  @override
  Widget build(BuildContext context) {
    final charkhName = state.charkh?.name ?? 'Active Charkh';
    return Row(
      children: [
        Expanded(
          child: Text(
            charkhName,
            style: Theme.of(context).textTheme.bodySmall,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(width: 16),
        Text(
          formatClock(state.fixedRouteDurationSeconds),
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}

class _ExpandedPanelDetails extends StatelessWidget {
  const _ExpandedPanelDetails({required this.state});

  final ActiveMapState state;

  @override
  Widget build(BuildContext context) {
    final routeMessage = state.routeMessage;
    final locationMessage = state.locationMessage;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        _StatusRow(
          label: 'Elapsed Time:',
          value: formatClock(state.elapsedSeconds),
        ),
        _StatusRow(
          label: 'ETA:',
          value: formatClock(state.fixedRouteDurationSeconds),
        ),
        _StatusRow(label: 'Next:', value: state.nextDestination),
        if (routeMessage != null && routeMessage.isNotEmpty) ...[
          const SizedBox(height: 8),
          _MessageText(routeMessage),
        ],
        if (locationMessage != null && locationMessage.isNotEmpty) ...[
          const SizedBox(height: 8),
          _MessageText(locationMessage),
        ],
      ],
    );
  }
}

class _MessageText extends StatelessWidget {
  const _MessageText(this.message);

  final String message;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(color: context.colors.error),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
