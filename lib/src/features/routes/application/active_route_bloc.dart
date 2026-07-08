import 'dart:async';
import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../charkhs/domain/charkh.dart';
import '../../destinations/domain/destination.dart';
import '../../locations/data/compass_heading_service.dart';
import '../../locations/data/current_location_service.dart';
import '../../locations/domain/coordinates.dart';
import '../../locations/domain/live_user_location.dart';
import '../data/active_route_repository.dart';
import '../data/directions_service.dart';
import '../domain/route_data.dart';

enum ActiveMapStatus { initial, loading, ready, failure }

enum ActiveMapPanelState { expanded, collapsed }

class ActiveMapState extends Equatable {
  const ActiveMapState({
    this.status = ActiveMapStatus.initial,
    this.charkh,
    this.destinations = const [],
    this.route,
    this.fixedRouteDurationSeconds = 0,
    this.elapsedSeconds = 0,
    this.currentDestinationIndex = 0,
    this.userLocation,
    this.deviceHeadingDegrees,
    this.userHeadingDegrees,
    this.smoothedCameraHeadingDegrees,
    this.userSpeedMetersPerSecond = 0,
    this.isCameraLockedToUser = true,
    this.currentZoom = 18,
    this.preferredFollowZoom = 18,
    this.currentRotation = 0,
    this.panelState = ActiveMapPanelState.collapsed,
    this.routeMessage,
    this.locationMessage,
  });

  final ActiveMapStatus status;
  final Charkh? charkh;
  final List<DestinationDraft> destinations;
  final RouteData? route;
  final int fixedRouteDurationSeconds;
  final int elapsedSeconds;
  final int currentDestinationIndex;
  final Coordinates? userLocation;
  final double? deviceHeadingDegrees;
  final double? userHeadingDegrees;
  final double? smoothedCameraHeadingDegrees;
  final double userSpeedMetersPerSecond;
  final bool isCameraLockedToUser;
  final double currentZoom;
  final double preferredFollowZoom;
  final double currentRotation;
  final ActiveMapPanelState panelState;
  final String? routeMessage;
  final String? locationMessage;

  bool get isPanelExpanded => panelState == ActiveMapPanelState.expanded;

  String get nextDestination {
    if (destinations.isEmpty) {
      return 'empty';
    }
    return destinations[min(currentDestinationIndex, destinations.length - 1)]
        .name;
  }

  ActiveMapState copyWith({
    ActiveMapStatus? status,
    Charkh? charkh,
    List<DestinationDraft>? destinations,
    Object? route = _unchanged,
    int? fixedRouteDurationSeconds,
    int? elapsedSeconds,
    int? currentDestinationIndex,
    Object? userLocation = _unchanged,
    Object? deviceHeadingDegrees = _unchanged,
    Object? userHeadingDegrees = _unchanged,
    Object? smoothedCameraHeadingDegrees = _unchanged,
    double? userSpeedMetersPerSecond,
    bool? isCameraLockedToUser,
    double? currentZoom,
    double? preferredFollowZoom,
    double? currentRotation,
    ActiveMapPanelState? panelState,
    Object? routeMessage = _unchanged,
    Object? locationMessage = _unchanged,
  }) {
    return ActiveMapState(
      status: status ?? this.status,
      charkh: charkh ?? this.charkh,
      destinations: destinations ?? this.destinations,
      route: route == _unchanged ? this.route : route as RouteData?,
      fixedRouteDurationSeconds:
          fixedRouteDurationSeconds ?? this.fixedRouteDurationSeconds,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      currentDestinationIndex:
          currentDestinationIndex ?? this.currentDestinationIndex,
      userLocation: userLocation == _unchanged
          ? this.userLocation
          : userLocation as Coordinates?,
      deviceHeadingDegrees: deviceHeadingDegrees == _unchanged
          ? this.deviceHeadingDegrees
          : deviceHeadingDegrees as double?,
      userHeadingDegrees: userHeadingDegrees == _unchanged
          ? this.userHeadingDegrees
          : userHeadingDegrees as double?,
      smoothedCameraHeadingDegrees: smoothedCameraHeadingDegrees == _unchanged
          ? this.smoothedCameraHeadingDegrees
          : smoothedCameraHeadingDegrees as double?,
      userSpeedMetersPerSecond:
          userSpeedMetersPerSecond ?? this.userSpeedMetersPerSecond,
      isCameraLockedToUser: isCameraLockedToUser ?? this.isCameraLockedToUser,
      currentZoom: currentZoom ?? this.currentZoom,
      preferredFollowZoom: preferredFollowZoom ?? this.preferredFollowZoom,
      currentRotation: currentRotation ?? this.currentRotation,
      panelState: panelState ?? this.panelState,
      routeMessage: routeMessage == _unchanged
          ? this.routeMessage
          : routeMessage as String?,
      locationMessage: locationMessage == _unchanged
          ? this.locationMessage
          : locationMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    charkh,
    destinations,
    route,
    fixedRouteDurationSeconds,
    elapsedSeconds,
    currentDestinationIndex,
    userLocation,
    deviceHeadingDegrees,
    userHeadingDegrees,
    smoothedCameraHeadingDegrees,
    userSpeedMetersPerSecond,
    isCameraLockedToUser,
    currentZoom,
    preferredFollowZoom,
    currentRotation,
    panelState,
    routeMessage,
    locationMessage,
  ];
}

sealed class ActiveMapEvent extends Equatable {
  const ActiveMapEvent();

  @override
  List<Object?> get props => [];
}

class ActiveMapStarted extends ActiveMapEvent {
  const ActiveMapStarted(this.charkh);

  final Charkh charkh;

  @override
  List<Object?> get props => [charkh];
}

class ActiveMapTicked extends ActiveMapEvent {
  const ActiveMapTicked();
}

class ActiveMapPanelToggled extends ActiveMapEvent {
  const ActiveMapPanelToggled();
}

class ActiveMapPanelExpanded extends ActiveMapEvent {
  const ActiveMapPanelExpanded();
}

class ActiveMapPanelCollapsed extends ActiveMapEvent {
  const ActiveMapPanelCollapsed();
}

class ActiveMapCameraLocked extends ActiveMapEvent {
  const ActiveMapCameraLocked();
}

class ActiveMapCameraRelockRequested extends ActiveMapEvent {
  const ActiveMapCameraRelockRequested();
}

class ActiveMapCameraUnlocked extends ActiveMapEvent {
  const ActiveMapCameraUnlocked();
}

class ActiveMapCameraChanged extends ActiveMapEvent {
  const ActiveMapCameraChanged({required this.zoom, required this.rotation});

  final double zoom;
  final double rotation;

  @override
  List<Object?> get props => [zoom, rotation];
}

class _ActiveMapUserLocationChanged extends ActiveMapEvent {
  const _ActiveMapUserLocationChanged(this.location);

  final LiveUserLocation location;

  @override
  List<Object?> get props => [location];
}

class _ActiveMapCompassHeadingChanged extends ActiveMapEvent {
  const _ActiveMapCompassHeadingChanged(this.headingDegrees);

  final double headingDegrees;

  @override
  List<Object?> get props => [headingDegrees];
}

class _ActiveMapLocationFailed extends ActiveMapEvent {
  const _ActiveMapLocationFailed(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

class ActiveMapBloc extends Bloc<ActiveMapEvent, ActiveMapState> {
  ActiveMapBloc({
    required this.activeRouteRepository,
    required this.directionsService,
    required this.currentLocationService,
    required this.compassHeadingService,
  }) : super(const ActiveMapState()) {
    on<ActiveMapStarted>(_onStarted);
    on<ActiveMapTicked>(_onTicked);
    on<ActiveMapPanelToggled>(_onPanelToggled);
    on<ActiveMapPanelExpanded>(_onPanelExpanded);
    on<ActiveMapPanelCollapsed>(_onPanelCollapsed);
    on<ActiveMapCameraLocked>(_onCameraLocked);
    on<ActiveMapCameraRelockRequested>(_onCameraRelockRequested);
    on<ActiveMapCameraUnlocked>(_onCameraUnlocked);
    on<ActiveMapCameraChanged>(_onCameraChanged);
    on<_ActiveMapUserLocationChanged>(_onUserLocationChanged);
    on<_ActiveMapCompassHeadingChanged>(_onCompassHeadingChanged);
    on<_ActiveMapLocationFailed>(_onLocationFailed);
  }

  final ActiveRouteRepository activeRouteRepository;
  final DirectionsService directionsService;
  final CurrentLocationService currentLocationService;
  final CompassHeadingService compassHeadingService;

  Timer? _timer;
  StreamSubscription<LiveUserLocation>? _locationSubscription;
  StreamSubscription<double>? _headingSubscription;
  DateTime? _startedAt;

  Future<void> _onStarted(
    ActiveMapStarted event,
    Emitter<ActiveMapState> emit,
  ) async {
    _timer?.cancel();
    await _locationSubscription?.cancel();
    await _headingSubscription?.cancel();
    _startedAt = DateTime.now();

    final destinations = event.charkh.destinations
        .map(DestinationDraft.fromDestination)
        .toList(growable: false);
    emit(
      ActiveMapState(
        status: ActiveMapStatus.loading,
        charkh: event.charkh,
        destinations: destinations,
      ),
    );

    final Coordinates origin;
    try {
      origin = await currentLocationService.getCurrentCoordinates();
    } catch (error) {
      emit(
        state.copyWith(
          status: ActiveMapStatus.failure,
          locationMessage: error.toString(),
        ),
      );
      return;
    }

    final routeCoordinates = [
      origin,
      for (final destination in destinations)
        if (destination.coordinates != null) destination.coordinates!,
    ];

    if (routeCoordinates.length < 2) {
      emit(
        state.copyWith(
          status: ActiveMapStatus.failure,
          userLocation: origin,
          routeMessage: 'At least one destination location is required.',
        ),
      );
      await _startLocationStream(emit);
      _startHeadingStream();
      return;
    }

    RouteData route;
    String? routeMessage;
    try {
      route = await directionsService.calculate(routeCoordinates);
    } catch (error) {
      route = buildFallbackRoute(
        coordinates: routeCoordinates,
        timeMinutes: event.charkh.timeMinutes,
      );
      routeMessage = error.toString();
    }

    final fixedDuration = route.durationSeconds > 0
        ? route.durationSeconds
        : event.charkh.timeMinutes * 60;

    emit(
      state.copyWith(
        status: ActiveMapStatus.ready,
        route: route,
        fixedRouteDurationSeconds: fixedDuration,
        userLocation: origin,
        routeMessage: routeMessage,
      ),
    );
    await _persist(state);
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => add(const ActiveMapTicked()),
    );
    await _startLocationStream(emit);
    _startHeadingStream();
  }

  Future<void> _startLocationStream(Emitter<ActiveMapState> emit) async {
    try {
      final stream = await currentLocationService.watchLiveLocation();
      if (isClosed) {
        return;
      }
      _locationSubscription = stream.listen(
        (location) => add(_ActiveMapUserLocationChanged(location)),
        onError: (Object error) =>
            add(_ActiveMapLocationFailed(error.toString())),
      );
    } catch (error) {
      emit(state.copyWith(locationMessage: error.toString()));
    }
  }

  void _startHeadingStream() {
    final previousSubscription = _headingSubscription;
    if (previousSubscription != null) {
      unawaited(previousSubscription.cancel());
    }
    _headingSubscription = compassHeadingService.watchHeadingDegrees().listen(
      (heading) => add(_ActiveMapCompassHeadingChanged(heading)),
      onError: (_) {},
    );
  }

  Future<void> _onTicked(
    ActiveMapTicked event,
    Emitter<ActiveMapState> emit,
  ) async {
    final charkh = state.charkh;
    if (charkh == null || state.fixedRouteDurationSeconds <= 0) {
      return;
    }
    final elapsed = state.elapsedSeconds + 1;
    emit(
      state.copyWith(
        elapsedSeconds: elapsed,
        currentDestinationIndex: _currentDestinationIndex(
          elapsedSeconds: elapsed,
          fixedRouteDurationSeconds: state.fixedRouteDurationSeconds,
          destinationCount: state.destinations.length,
        ),
      ),
    );
    await _persist(state);
  }

  void _onPanelToggled(
    ActiveMapPanelToggled event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(
      state.copyWith(
        panelState: state.isPanelExpanded
            ? ActiveMapPanelState.collapsed
            : ActiveMapPanelState.expanded,
      ),
    );
  }

  void _onPanelExpanded(
    ActiveMapPanelExpanded event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(state.copyWith(panelState: ActiveMapPanelState.expanded));
  }

  void _onPanelCollapsed(
    ActiveMapPanelCollapsed event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(state.copyWith(panelState: ActiveMapPanelState.collapsed));
  }

  void _onCameraLocked(
    ActiveMapCameraLocked event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(state.copyWith(isCameraLockedToUser: true));
  }

  void _onCameraRelockRequested(
    ActiveMapCameraRelockRequested event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(state.copyWith(isCameraLockedToUser: true, locationMessage: null));

    if (state.userLocation == null) {
      unawaited(_loadLastKnownLocation());
    }
  }

  Future<void> _loadLastKnownLocation() async {
    try {
      final cachedLocation = await currentLocationService
          .getLastKnownLiveLocation();
      if (cachedLocation != null) {
        add(_ActiveMapUserLocationChanged(cachedLocation));
      }
    } catch (error) {
      add(_ActiveMapLocationFailed(error.toString()));
    }
  }

  void _onCameraUnlocked(
    ActiveMapCameraUnlocked event,
    Emitter<ActiveMapState> emit,
  ) {
    if (!state.isCameraLockedToUser) {
      return;
    }
    emit(state.copyWith(isCameraLockedToUser: false));
  }

  void _onCameraChanged(
    ActiveMapCameraChanged event,
    Emitter<ActiveMapState> emit,
  ) {
    final zoomChanged = (event.zoom - state.currentZoom).abs() >= 0.01;
    final rotationChanged =
        (event.rotation - state.currentRotation).abs() >= 0.01;
    if (!zoomChanged && !rotationChanged) {
      return;
    }
    emit(
      state.copyWith(currentZoom: event.zoom, currentRotation: event.rotation),
    );
  }

  void _onUserLocationChanged(
    _ActiveMapUserLocationChanged event,
    Emitter<ActiveMapState> emit,
  ) {
    _emitUserLocation(event.location, emit);
  }

  void _onCompassHeadingChanged(
    _ActiveMapCompassHeadingChanged event,
    Emitter<ActiveMapState> emit,
  ) {
    final previousHeading = state.deviceHeadingDegrees;
    if (previousHeading != null &&
        _angleDistance(previousHeading, event.headingDegrees) <
            _minimumCompassHeadingDeltaDegrees) {
      return;
    }

    final smoothedHeading = _smoothHeading(
      state.smoothedCameraHeadingDegrees ?? event.headingDegrees,
      event.headingDegrees,
      _compassHeadingSmoothingFactor,
    );

    emit(
      state.copyWith(
        deviceHeadingDegrees: event.headingDegrees,
        smoothedCameraHeadingDegrees: smoothedHeading,
      ),
    );
  }

  void _emitUserLocation(
    LiveUserLocation location,
    Emitter<ActiveMapState> emit,
  ) {
    final rawHeading = _headingForLocation(location, state.userLocation);
    final smoothedHeading = rawHeading == null
        ? state.smoothedCameraHeadingDegrees
        : _smoothHeading(
            state.smoothedCameraHeadingDegrees ??
                state.userHeadingDegrees ??
                rawHeading,
            rawHeading,
            _headingSmoothingFactor,
          );

    emit(
      state.copyWith(
        userLocation: location.coordinates,
        userHeadingDegrees: rawHeading,
        smoothedCameraHeadingDegrees: smoothedHeading,
        userSpeedMetersPerSecond: location.speedMetersPerSecond,
        locationMessage: null,
      ),
    );
  }

  void _onLocationFailed(
    _ActiveMapLocationFailed event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(state.copyWith(locationMessage: event.message));
  }

  Future<void> _persist(ActiveMapState value) async {
    if (value.charkh == null || _startedAt == null) {
      return;
    }
    await activeRouteRepository.saveActiveRoute(
      charkhStableId: value.charkh!.stableId,
      startedAt: _startedAt!,
      elapsedSeconds: value.elapsedSeconds,
      etaSeconds: value.fixedRouteDurationSeconds,
      currentDestinationIndex: value.currentDestinationIndex,
    );
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    await _locationSubscription?.cancel();
    await _headingSubscription?.cancel();
    return super.close();
  }
}

int _currentDestinationIndex({
  required int elapsedSeconds,
  required int fixedRouteDurationSeconds,
  required int destinationCount,
}) {
  if (destinationCount <= 0 || fixedRouteDurationSeconds <= 0) {
    return 0;
  }
  final segment = max(1, fixedRouteDurationSeconds ~/ destinationCount);
  return min(destinationCount - 1, elapsedSeconds ~/ segment);
}

const Object _unchanged = Object();

const _minimumHeadingSpeedMetersPerSecond = 0.7;
const _minimumBearingDistanceMeters = 3.0;
const _headingSmoothingFactor = 0.22;
const _compassHeadingSmoothingFactor = 0.42;
const _minimumCompassHeadingDeltaDegrees = 0.6;

double? _headingForLocation(
  LiveUserLocation location,
  Coordinates? previousCoordinates,
) {
  if (_isUsableHeading(
    location.headingDegrees,
    location.speedMetersPerSecond,
  )) {
    return location.headingDegrees;
  }

  if (previousCoordinates == null) {
    return null;
  }

  final distance = _distanceMeters(previousCoordinates, location.coordinates);
  if (distance < _minimumBearingDistanceMeters) {
    return null;
  }
  return _bearingBetween(previousCoordinates, location.coordinates);
}

bool _isUsableHeading(double? heading, double speedMetersPerSecond) {
  return heading != null &&
      heading.isFinite &&
      speedMetersPerSecond >= _minimumHeadingSpeedMetersPerSecond;
}

double _smoothHeading(double from, double to, double factor) {
  final delta = _shortestAngleDelta(from, to);
  return _normalizeDegrees(from + delta * factor);
}

double _shortestAngleDelta(double from, double to) {
  return ((to - from + 540) % 360) - 180;
}

double _angleDistance(double from, double to) {
  return _shortestAngleDelta(from, to).abs();
}

double _bearingBetween(Coordinates from, Coordinates to) {
  final fromLat = _degreesToRadians(from.latitude);
  final toLat = _degreesToRadians(to.latitude);
  final deltaLng = _degreesToRadians(to.longitude - from.longitude);
  final y = sin(deltaLng) * cos(toLat);
  final x =
      cos(fromLat) * sin(toLat) - sin(fromLat) * cos(toLat) * cos(deltaLng);
  return _normalizeDegrees(_radiansToDegrees(atan2(y, x)));
}

double _distanceMeters(Coordinates a, Coordinates b) {
  const earthRadiusMeters = 6371000.0;
  final deltaLat = _degreesToRadians(b.latitude - a.latitude);
  final deltaLng = _degreesToRadians(b.longitude - a.longitude);
  final startLat = _degreesToRadians(a.latitude);
  final endLat = _degreesToRadians(b.latitude);
  final haversine =
      sin(deltaLat / 2) * sin(deltaLat / 2) +
      cos(startLat) * cos(endLat) * sin(deltaLng / 2) * sin(deltaLng / 2);
  return earthRadiusMeters * 2 * atan2(sqrt(haversine), sqrt(1 - haversine));
}

double _degreesToRadians(double degrees) => degrees * pi / 180;

double _radiansToDegrees(double radians) => radians * 180 / pi;

double _normalizeDegrees(double degrees) {
  final normalized = degrees % 360;
  return normalized < 0 ? normalized + 360 : normalized;
}
