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
import '../../locations/data/compass_heading_service.dart';
import '../../locations/data/current_location_service.dart';
import '../../locations/domain/coordinates.dart';
import '../../profile/data/profile_repository.dart';
import '../application/active_route_bloc.dart';
import '../data/active_route_repository.dart';
import '../data/charkh_history_repository.dart';
import '../data/directions_service.dart';

class ActiveMapScreen extends StatelessWidget {
  const ActiveMapScreen({
    super.key,
    required this.charkhStableId,
    required this.charkhRepository,
    required this.activeRouteRepository,
    required this.charkhHistoryRepository,
    required this.profileRepository,
    required this.directionsService,
    required this.currentLocationService,
    required this.compassHeadingService,
  });

  final String charkhStableId;
  final CharkhRepository charkhRepository;
  final ActiveRouteRepository activeRouteRepository;
  final CharkhHistoryRepository charkhHistoryRepository;
  final ProfileRepository profileRepository;
  final DirectionsService directionsService;
  final CurrentLocationService currentLocationService;
  final CompassHeadingService compassHeadingService;

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
            charkhHistoryRepository: charkhHistoryRepository,
            profileRepository: profileRepository,
            directionsService: directionsService,
            currentLocationService: currentLocationService,
            compassHeadingService: compassHeadingService,
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
    with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  static const _maxActiveMapZoom = 20.5;

  late final MapController _mapController;
  late final AnimationController _cameraAnimationController;

  bool _mapReady = false;
  Coordinates? _pendingCameraTarget;
  DateTime? _lastCameraFollowAt;
  ActiveMapState? _previousListenedState;
  VoidCallback? _cameraAnimationListener;
  bool _forceNextRelockLocationAnimation = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _mapController = MapController();
    _cameraAnimationController = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _removeCameraAnimationListener();
    _cameraAnimationController.dispose();
    _mapController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed && mounted) {
      context.read<ActiveMapBloc>().add(
        const ActiveMapLocationRetryRequested(),
      );
    }
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
        targetRotation: _mapRotationForHeading(
          state.smoothedCameraHeadingDegrees,
        ),
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
      final headingOnly = headingChanged && !locationChanged && !relocked;
      final forceRelockLocation =
          _forceNextRelockLocationAnimation && locationChanged;
      if (forceRelockLocation) {
        _forceNextRelockLocationAnimation = false;
      }
      _animateCameraTo(
        target,
        force: relocked || forceRelockLocation,
        targetZoom: relocked || forceRelockLocation
            ? current.preferredFollowZoom
            : null,
        targetRotation: _mapRotationForHeading(
          current.smoothedCameraHeadingDegrees,
        ),
        duration: headingOnly
            ? const Duration(milliseconds: 160)
            : const Duration(milliseconds: 620),
        throttleDuration: headingOnly
            ? const Duration(milliseconds: 48)
            : const Duration(milliseconds: 320),
        minimumRotationDelta: headingOnly ? 0.35 : 1,
      );
    }
  }

  void _relockCamera(ActiveMapState state) {
    _forceNextRelockLocationAnimation = true;
    context.read<ActiveMapBloc>().add(const ActiveMapCameraRelockRequested());
    final target = state.userLocation;
    if (target != null) {
      _animateCameraTo(
        target,
        force: true,
        targetZoom: state.preferredFollowZoom,
        targetRotation: _mapRotationForHeading(
          state.smoothedCameraHeadingDegrees,
        ),
      );
    }
  }

  void _animateCameraTo(
    Coordinates target, {
    required bool force,
    double? targetZoom,
    double? targetRotation,
    Duration duration = const Duration(milliseconds: 620),
    Duration throttleDuration = const Duration(milliseconds: 320),
    double minimumRotationDelta = 1,
  }) {
    if (!_mapReady) {
      _pendingCameraTarget = target;
      return;
    }

    final now = DateTime.now();
    if (!force &&
        _lastCameraFollowAt != null &&
        now.difference(_lastCameraFollowAt!) < throttleDuration) {
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
        rotationDistance < minimumRotationDelta) {
      return;
    }

    _lastCameraFollowAt = now;
    _cameraAnimationController.stop();
    _removeCameraAnimationListener();
    _cameraAnimationController.duration = duration;

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
    late final VoidCallback listener;
    listener = () {
      final eased = Curves.easeOutCubic.transform(
        _cameraAnimationController.value,
      );
      _mapController.moveAndRotate(
        centerTween.transform(eased),
        zoomTween.transform(eased),
        rotationTween.transform(eased),
      );
    };
    _cameraAnimationListener = listener;

    _cameraAnimationController
      ..addListener(listener)
      ..forward(from: 0).whenCompleteOrCancel(() {
        _removeCameraAnimationListener(listener);
      });
  }

  void _removeCameraAnimationListener([VoidCallback? expectedListener]) {
    final listener = _cameraAnimationListener;
    if (listener == null) {
      return;
    }
    if (expectedListener != null && listener != expectedListener) {
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
                  if (state.isLocationRecoveryPromptVisible)
                    _LocationServicesPrompt(
                      isOpeningSettings: state.isOpeningLocationSettings,
                    ),
                  _RoutePanel(
                    state: state,
                    cameraButton: _CameraFollowButton(
                      isLocked: state.isCameraLockedToUser,
                      onPressed: () => _relockCamera(state),
                    ),
                  ),
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

double? _mapRotationForHeading(double? headingDegrees) {
  if (headingDegrees == null) {
    return null;
  }
  return _normalizeDegrees(-headingDegrees);
}

double _shortestAngleDelta(double from, double to) {
  return ((to - from + 540) % 360) - 180;
}

double _normalizeDegrees(double degrees) {
  final normalized = degrees % 360;
  return normalized < 0 ? normalized + 360 : normalized;
}

class _LocationServicesPrompt extends StatelessWidget {
  const _LocationServicesPrompt({required this.isOpeningSettings});

  final bool isOpeningSettings;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      top: MediaQuery.paddingOf(context).top + 24,
      child: Material(
        color: context.colors.surface,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Turn on GPS to start this charkh.',
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(height: 8),
              Text(
                'KosCharkh needs your current location to calculate and show the active route.',
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: context.colors.onSurfaceMuted,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: KosButton(
                      text: isOpeningSettings ? 'Opening...' : 'Turn On GPS',
                      height: 38,
                      onPressed: isOpeningSettings
                          ? null
                          : () => context.read<ActiveMapBloc>().add(
                              const ActiveMapLocationSettingsRequested(),
                            ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: KosButton(
                      text: 'Retry',
                      height: 38,
                      variant: KosButtonVariant.secondary,
                      onPressed: () => context.read<ActiveMapBloc>().add(
                        const ActiveMapLocationRetryRequested(),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CameraFollowButton extends StatelessWidget {
  const _CameraFollowButton({required this.isLocked, required this.onPressed});

  final bool isLocked;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconSquareButton(
      asset: KosAssets.myLocation,
      onPressed: onPressed,
      backgroundColor: isLocked
          ? context.colors.green900
          : context.colors.primary,
      iconColor: context.colors.onSurface,
    );
  }
}

class _RoutePanel extends StatelessWidget {
  const _RoutePanel({required this.state, required this.cameraButton});

  final ActiveMapState state;
  final Widget cameraButton;

  void _toggleSheet(BuildContext context) {
    context.read<ActiveMapBloc>().add(const ActiveMapPanelToggled());
  }

  void _handleDragEnd(BuildContext context, DragEndDetails details) {
    final velocity = details.primaryVelocity ?? 0;
    if (velocity < -120) {
      context.read<ActiveMapBloc>().add(const ActiveMapPanelExpanded());
    } else if (velocity > 120) {
      context.read<ActiveMapBloc>().add(const ActiveMapPanelCollapsed());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final maxHeight = MediaQuery.sizeOf(context).height * 0.82;
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 24, bottom: 24),
            child: Align(alignment: Alignment.centerRight, child: cameraButton),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: Alignment.bottomCenter,
            child: GestureDetector(
              onVerticalDragEnd: (details) => _handleDragEnd(context, details),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: maxHeight),
                child: Material(
                  color: context.colors.surface,
                  child: SingleChildScrollView(
                    physics: const ClampingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(24, 8, 24, 18 + bottomInset),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _PanelHandle(onTap: () => _toggleSheet(context)),
                          const SizedBox(height: 18),
                          _PanelHeader(state: state),
                          AnimatedCrossFade(
                            firstChild: const SizedBox(width: double.infinity),
                            secondChild: _ExpandedPanelDetails(state: state),
                            crossFadeState: state.isPanelExpanded
                                ? CrossFadeState.showSecond
                                : CrossFadeState.showFirst,
                            duration: const Duration(milliseconds: 180),
                            sizeCurve: Curves.easeOutCubic,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
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
        if (state.isFinishPromptVisible) ...[
          const SizedBox(height: 10),
          _FinishPrompt(state: state),
        ],
        if (state.finishMessage != null && state.finishMessage!.isNotEmpty) ...[
          const SizedBox(height: 8),
          _FinishMessageText(state.finishMessage!, isSuccess: state.isFinished),
        ],
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

class _FinishPrompt extends StatelessWidget {
  const _FinishPrompt({required this.state});

  final ActiveMapState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.surfaceMuted,
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Charkh finished. Record it now or it will be saved automatically.',
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: KosButton(
                  text: 'Record (${state.finishCountdownSeconds})',
                  height: 34,
                  onPressed: () => context.read<ActiveMapBloc>().add(
                    const ActiveMapFinishConfirmed(),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: KosButton(
                  text: 'Keep Going',
                  height: 34,
                  variant: KosButtonVariant.secondary,
                  onPressed: () => context.read<ActiveMapBloc>().add(
                    const ActiveMapFinishDismissed(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _FinishMessageText extends StatelessWidget {
  const _FinishMessageText(this.message, {required this.isSuccess});

  final String message;
  final bool isSuccess;

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      style: Theme.of(context).textTheme.bodySmall?.copyWith(
        color: isSuccess ? context.colors.success : context.colors.warning,
      ),
      maxLines: 2,
      overflow: TextOverflow.ellipsis,
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
