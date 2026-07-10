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
import '../../profile/data/profile_repository.dart';
import '../data/active_route_repository.dart';
import '../data/charkh_history_repository.dart';
import '../data/directions_service.dart';
import '../domain/route_data.dart';
import '../domain/walking_route_progress.dart';

enum ActiveMapStatus { initial, loading, ready, failure }

enum ActiveMapPanelState { expanded, collapsed }

enum ActiveMapFinishStatus { running, prompting, recorded }

class ActiveMapState extends Equatable {
  const ActiveMapState({
    this.status = ActiveMapStatus.initial,
    this.charkh,
    this.destinations = const [],
    this.route,
    this.fixedRouteDurationSeconds = 0,
    this.estimatedRemainingSeconds = 0,
    this.remainingDistanceMeters = 0,
    this.distanceToNextDestinationMeters,
    this.elapsedSeconds = 0,
    this.currentDestinationIndex = 0,
    this.routeStartDestinationIndex = 0,
    this.userLocation,
    this.deviceHeadingDegrees,
    this.userHeadingDegrees,
    this.smoothedCameraHeadingDegrees,
    this.userSpeedMetersPerSecond = 0,
    this.isCameraLockedToUser = true,
    this.currentZoom = 18,
    this.preferredFollowZoom = 18,
    this.currentRotation = 0,
    this.panelState = ActiveMapPanelState.expanded,
    this.finishStatus = ActiveMapFinishStatus.running,
    this.finishCountdownSeconds = 0,
    this.finishPromptDismissed = false,
    this.isOpeningLocationSettings = false,
    this.isOffRoute = false,
    this.routeMessage,
    this.locationMessage,
    this.navigationMessage,
    this.finishMessage,
  });

  final ActiveMapStatus status;
  final Charkh? charkh;
  final List<DestinationDraft> destinations;
  final RouteData? route;
  final int fixedRouteDurationSeconds;
  final int estimatedRemainingSeconds;
  final double remainingDistanceMeters;
  final double? distanceToNextDestinationMeters;
  final int elapsedSeconds;
  final int currentDestinationIndex;
  final int routeStartDestinationIndex;
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
  final ActiveMapFinishStatus finishStatus;
  final int finishCountdownSeconds;
  final bool finishPromptDismissed;
  final bool isOpeningLocationSettings;
  final bool isOffRoute;
  final String? routeMessage;
  final String? locationMessage;
  final String? navigationMessage;
  final String? finishMessage;

  bool get isPanelExpanded => panelState == ActiveMapPanelState.expanded;
  bool get isFinishPromptVisible =>
      finishStatus == ActiveMapFinishStatus.prompting;
  bool get isFinished => finishStatus == ActiveMapFinishStatus.recorded;
  bool get isLocationServiceDisabled =>
      locationMessage == _locationServicesDisabledMessage;
  bool get isLocationRecoveryPromptVisible =>
      status == ActiveMapStatus.failure &&
      (isLocationServiceDisabled ||
          isOpeningLocationSettings ||
          locationMessage == _locationSettingsPromptMessage);

  String get nextDestination {
    if (destinations.isEmpty) {
      return 'empty';
    }
    if (currentDestinationIndex >= destinations.length) {
      return 'Completed';
    }
    return destinations[currentDestinationIndex].name;
  }

  ActiveMapState copyWith({
    ActiveMapStatus? status,
    Charkh? charkh,
    List<DestinationDraft>? destinations,
    Object? route = _unchanged,
    int? fixedRouteDurationSeconds,
    int? estimatedRemainingSeconds,
    double? remainingDistanceMeters,
    Object? distanceToNextDestinationMeters = _unchanged,
    int? elapsedSeconds,
    int? currentDestinationIndex,
    int? routeStartDestinationIndex,
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
    ActiveMapFinishStatus? finishStatus,
    int? finishCountdownSeconds,
    bool? finishPromptDismissed,
    bool? isOpeningLocationSettings,
    bool? isOffRoute,
    Object? routeMessage = _unchanged,
    Object? locationMessage = _unchanged,
    Object? navigationMessage = _unchanged,
    Object? finishMessage = _unchanged,
  }) {
    return ActiveMapState(
      status: status ?? this.status,
      charkh: charkh ?? this.charkh,
      destinations: destinations ?? this.destinations,
      route: route == _unchanged ? this.route : route as RouteData?,
      fixedRouteDurationSeconds:
          fixedRouteDurationSeconds ?? this.fixedRouteDurationSeconds,
      estimatedRemainingSeconds:
          estimatedRemainingSeconds ?? this.estimatedRemainingSeconds,
      remainingDistanceMeters:
          remainingDistanceMeters ?? this.remainingDistanceMeters,
      distanceToNextDestinationMeters:
          distanceToNextDestinationMeters == _unchanged
          ? this.distanceToNextDestinationMeters
          : distanceToNextDestinationMeters as double?,
      elapsedSeconds: elapsedSeconds ?? this.elapsedSeconds,
      currentDestinationIndex:
          currentDestinationIndex ?? this.currentDestinationIndex,
      routeStartDestinationIndex:
          routeStartDestinationIndex ?? this.routeStartDestinationIndex,
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
      finishStatus: finishStatus ?? this.finishStatus,
      finishCountdownSeconds:
          finishCountdownSeconds ?? this.finishCountdownSeconds,
      finishPromptDismissed:
          finishPromptDismissed ?? this.finishPromptDismissed,
      isOpeningLocationSettings:
          isOpeningLocationSettings ?? this.isOpeningLocationSettings,
      isOffRoute: isOffRoute ?? this.isOffRoute,
      routeMessage: routeMessage == _unchanged
          ? this.routeMessage
          : routeMessage as String?,
      locationMessage: locationMessage == _unchanged
          ? this.locationMessage
          : locationMessage as String?,
      navigationMessage: navigationMessage == _unchanged
          ? this.navigationMessage
          : navigationMessage as String?,
      finishMessage: finishMessage == _unchanged
          ? this.finishMessage
          : finishMessage as String?,
    );
  }

  @override
  List<Object?> get props => [
    status,
    charkh,
    destinations,
    route,
    fixedRouteDurationSeconds,
    estimatedRemainingSeconds,
    remainingDistanceMeters,
    distanceToNextDestinationMeters,
    elapsedSeconds,
    currentDestinationIndex,
    routeStartDestinationIndex,
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
    finishStatus,
    finishCountdownSeconds,
    finishPromptDismissed,
    isOpeningLocationSettings,
    isOffRoute,
    routeMessage,
    locationMessage,
    navigationMessage,
    finishMessage,
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

class ActiveMapFinishConfirmed extends ActiveMapEvent {
  const ActiveMapFinishConfirmed();
}

class ActiveMapFinishDismissed extends ActiveMapEvent {
  const ActiveMapFinishDismissed();
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

class ActiveMapLocationSettingsRequested extends ActiveMapEvent {
  const ActiveMapLocationSettingsRequested();
}

class ActiveMapLocationRetryRequested extends ActiveMapEvent {
  const ActiveMapLocationRetryRequested();
}

class _ActiveMapUserLocationChanged extends ActiveMapEvent {
  const _ActiveMapUserLocationChanged(this.location);

  final LiveUserLocation location;

  @override
  List<Object?> get props => [location];
}

class _ActiveMapRerouteRequested extends ActiveMapEvent {
  const _ActiveMapRerouteRequested({
    required this.location,
    required this.destinationIndex,
  });

  final Coordinates location;
  final int destinationIndex;

  @override
  List<Object?> get props => [location, destinationIndex];
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
    required this.charkhHistoryRepository,
    required this.profileRepository,
    required this.directionsService,
    required this.currentLocationService,
    required this.compassHeadingService,
  }) : super(const ActiveMapState()) {
    on<ActiveMapStarted>(_onStarted);
    on<ActiveMapTicked>(_onTicked);
    on<ActiveMapPanelToggled>(_onPanelToggled);
    on<ActiveMapPanelExpanded>(_onPanelExpanded);
    on<ActiveMapPanelCollapsed>(_onPanelCollapsed);
    on<ActiveMapFinishConfirmed>(_onFinishConfirmed);
    on<ActiveMapFinishDismissed>(_onFinishDismissed);
    on<ActiveMapCameraLocked>(_onCameraLocked);
    on<ActiveMapCameraRelockRequested>(_onCameraRelockRequested);
    on<ActiveMapCameraUnlocked>(_onCameraUnlocked);
    on<ActiveMapCameraChanged>(_onCameraChanged);
    on<ActiveMapLocationSettingsRequested>(_onLocationSettingsRequested);
    on<ActiveMapLocationRetryRequested>(_onLocationRetryRequested);
    on<_ActiveMapUserLocationChanged>(_onUserLocationChanged);
    on<_ActiveMapRerouteRequested>(_onRerouteRequested);
    on<_ActiveMapCompassHeadingChanged>(_onCompassHeadingChanged);
    on<_ActiveMapLocationFailed>(_onLocationFailed);
  }

  final ActiveRouteRepository activeRouteRepository;
  final CharkhHistoryRepository charkhHistoryRepository;
  final ProfileRepository profileRepository;
  final DirectionsService directionsService;
  final CurrentLocationService currentLocationService;
  final CompassHeadingService compassHeadingService;

  Timer? _timer;
  StreamSubscription<LiveUserLocation>? _locationSubscription;
  StreamSubscription<double>? _headingSubscription;
  DateTime? _startedAt;
  DateTime? _lastRerouteAt;
  DateTime? _lastProgressSampleAt;
  int _arrivalCandidateSamples = 0;
  int _offRouteSamples = 0;
  bool _isRerouting = false;

  Future<void> _onStarted(
    ActiveMapStarted event,
    Emitter<ActiveMapState> emit,
  ) async {
    _timer?.cancel();
    await _locationSubscription?.cancel();
    await _headingSubscription?.cancel();
    _startedAt = DateTime.now();
    _lastRerouteAt = null;
    _lastProgressSampleAt = null;
    _arrivalCandidateSamples = 0;
    _offRouteSamples = 0;
    _isRerouting = false;

    final destinations = event.charkh.destinations
        .map(DestinationDraft.fromDestination)
        .where((destination) => destination.coordinates != null)
        .toList(growable: false);
    final skippedDestinationCount =
        event.charkh.destinations.length - destinations.length;
    emit(
      ActiveMapState(
        status: ActiveMapStatus.loading,
        charkh: event.charkh,
        destinations: destinations,
        routeMessage: skippedDestinationCount == 0
            ? null
            : '$skippedDestinationCount destination(s) without a location were skipped.',
      ),
    );
    await _startRouteFromCurrentLocation(event.charkh, emit);
  }

  Future<void> _startRouteFromCurrentLocation(
    Charkh charkh,
    Emitter<ActiveMapState> emit,
  ) async {
    final LiveUserLocation originLocation;
    try {
      originLocation = await currentLocationService.getCurrentLiveLocation();
    } catch (error) {
      final message = _normalizeLocationErrorMessage(error);
      emit(
        state.copyWith(
          status: ActiveMapStatus.failure,
          locationMessage: message,
          isOpeningLocationSettings: false,
        ),
      );
      return;
    }
    final origin = originLocation.coordinates;

    final routeCoordinates = [
      origin,
      for (final destination in state.destinations)
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
        timeMinutes: charkh.timeMinutes,
      );
      routeMessage = error.toString();
    }

    final fixedDuration = route.durationSeconds > 0
        ? route.durationSeconds
        : charkh.timeMinutes * 60;

    emit(
      state.copyWith(
        status: ActiveMapStatus.ready,
        route: route,
        fixedRouteDurationSeconds: fixedDuration,
        estimatedRemainingSeconds: fixedDuration,
        remainingDistanceMeters: route.distanceMeters,
        distanceToNextDestinationMeters: state.destinations.isEmpty
            ? null
            : distanceMeters(origin, state.destinations.first.coordinates!),
        userLocation: origin,
        routeMessage: routeMessage ?? state.routeMessage,
        locationMessage: null,
        navigationMessage: null,
        isOffRoute: false,
        isOpeningLocationSettings: false,
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
      emit(
        state.copyWith(locationMessage: _normalizeLocationErrorMessage(error)),
      );
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
    if (charkh == null || state.isFinished) {
      return;
    }
    final elapsed = state.elapsedSeconds + 1;
    var nextState = state.copyWith(elapsedSeconds: elapsed);

    if (state.finishStatus == ActiveMapFinishStatus.prompting) {
      final countdown = max(0, state.finishCountdownSeconds - 1);
      nextState = nextState.copyWith(
        finishCountdownSeconds: countdown,
        panelState: ActiveMapPanelState.expanded,
      );
      emit(nextState);
      await _persist(nextState);
      if (countdown == 0) {
        await _recordCompletion(emit);
      }
      return;
    }

    emit(nextState);
    if (elapsed % _activeRoutePersistenceIntervalSeconds == 0) {
      await _persist(nextState);
    }
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

  Future<void> _onFinishConfirmed(
    ActiveMapFinishConfirmed event,
    Emitter<ActiveMapState> emit,
  ) async {
    await _recordCompletion(emit);
  }

  void _onFinishDismissed(
    ActiveMapFinishDismissed event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(
      state.copyWith(
        finishStatus: ActiveMapFinishStatus.running,
        finishCountdownSeconds: 0,
        finishPromptDismissed: true,
        finishMessage: 'Charkh is still active.',
      ),
    );
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

  Future<void> _onLocationSettingsRequested(
    ActiveMapLocationSettingsRequested event,
    Emitter<ActiveMapState> emit,
  ) async {
    emit(
      state.copyWith(
        isOpeningLocationSettings: true,
        locationMessage: _locationSettingsPromptMessage,
      ),
    );
    try {
      await currentLocationService.openLocationSettings();
    } catch (error) {
      emit(
        state.copyWith(
          isOpeningLocationSettings: false,
          locationMessage: error.toString(),
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        isOpeningLocationSettings: false,
        locationMessage: _locationSettingsPromptMessage,
      ),
    );
  }

  Future<void> _onLocationRetryRequested(
    ActiveMapLocationRetryRequested event,
    Emitter<ActiveMapState> emit,
  ) async {
    final charkh = state.charkh;
    if (charkh == null ||
        state.status == ActiveMapStatus.loading ||
        state.status == ActiveMapStatus.ready) {
      return;
    }
    final isEnabled = await currentLocationService.isLocationServiceEnabled();
    if (!isEnabled) {
      emit(
        state.copyWith(
          status: ActiveMapStatus.failure,
          locationMessage: _locationServicesDisabledMessage,
        ),
      );
      return;
    }
    emit(
      state.copyWith(
        status: ActiveMapStatus.loading,
        locationMessage: null,
        routeMessage: null,
      ),
    );
    await _startRouteFromCurrentLocation(charkh, emit);
  }

  Future<void> _onUserLocationChanged(
    _ActiveMapUserLocationChanged event,
    Emitter<ActiveMapState> emit,
  ) async {
    emit(_stateWithUserLocation(event.location));
    await _updateWalkingRouteProgress(event.location, emit);
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

  ActiveMapState _stateWithUserLocation(LiveUserLocation location) {
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

    return state.copyWith(
      userLocation: location.coordinates,
      userHeadingDegrees: rawHeading,
      smoothedCameraHeadingDegrees: smoothedHeading,
      userSpeedMetersPerSecond: location.speedMetersPerSecond,
      locationMessage: null,
    );
  }

  Future<void> _updateWalkingRouteProgress(
    LiveUserLocation location,
    Emitter<ActiveMapState> emit,
  ) async {
    final route = state.route;
    final destinationIndex = state.currentDestinationIndex;
    if (state.status != ActiveMapStatus.ready ||
        route == null ||
        destinationIndex >= state.destinations.length ||
        state.isFinished ||
        !WalkingRouteProgressPolicy.isReliable(location, now: DateTime.now())) {
      return;
    }
    if (location.timestamp != null &&
        location.timestamp == _lastProgressSampleAt) {
      return;
    }
    _lastProgressSampleAt = location.timestamp;

    final legIndex = destinationIndex - state.routeStartDestinationIndex;
    if (legIndex < 0 || legIndex >= route.legs.length) {
      return;
    }
    final destination = state.destinations[destinationIndex];
    final destinationCoordinates = destination.coordinates;
    if (destinationCoordinates == null) {
      return;
    }

    final projection = projectLocationOntoLeg(
      location: location.coordinates,
      leg: route.legs[legIndex],
    );
    final directDistance = distanceMeters(
      location.coordinates,
      destinationCoordinates,
    );
    final remaining = _remainingRouteProgress(
      route: route,
      activeLegIndex: legIndex,
      projection: projection,
    );
    var progressState = state.copyWith(
      estimatedRemainingSeconds: remaining.durationSeconds,
      remainingDistanceMeters: remaining.distanceMeters,
      distanceToNextDestinationMeters: directDistance,
    );

    final arrivalRadius = WalkingRouteProgressPolicy.arrivalRadius(
      location.accuracyMeters,
    );
    final isArrivalCandidate =
        directDistance <= arrivalRadius ||
        (projection.remainingRouteDistanceMeters <=
                WalkingRouteProgressPolicy.endpointRemainingDistanceMeters &&
            directDistance <=
                WalkingRouteProgressPolicy.endpointPassRadiusMeters);
    if (isArrivalCandidate) {
      _arrivalCandidateSamples += 1;
    } else if (directDistance >=
        WalkingRouteProgressPolicy.arrivalExitRadiusMeters) {
      _arrivalCandidateSamples = 0;
    }

    if (_arrivalCandidateSamples >=
        WalkingRouteProgressPolicy.arrivalConfirmationSamples) {
      _arrivalCandidateSamples = 0;
      _offRouteSamples = 0;
      await _advanceToNextDestination(progressState, emit);
      return;
    }

    if (route.source != 'mapbox') {
      _offRouteSamples = 0;
      emit(
        progressState.copyWith(
          isOffRoute: false,
          navigationMessage: null,
        ),
      );
      return;
    }

    final offRouteThreshold = WalkingRouteProgressPolicy.offRouteThreshold(
      location.accuracyMeters,
    );
    if (projection.distanceFromRouteMeters > offRouteThreshold) {
      _offRouteSamples += 1;
    } else {
      _offRouteSamples = 0;
      if (progressState.isOffRoute && !_isRerouting) {
        progressState = progressState.copyWith(
          isOffRoute: false,
          navigationMessage: null,
        );
      }
    }

    if (_offRouteSamples >=
        WalkingRouteProgressPolicy.offRouteConfirmationSamples) {
      progressState = progressState.copyWith(
        isOffRoute: true,
        navigationMessage: _isRerouting
            ? 'Updating walking route...'
            : 'You are off the walking route.',
      );
      emit(progressState);
      _requestReroute(location.coordinates, destinationIndex);
      return;
    }

    emit(progressState);
  }

  Future<void> _advanceToNextDestination(
    ActiveMapState progressState,
    Emitter<ActiveMapState> emit,
  ) async {
    final nextIndex = progressState.currentDestinationIndex + 1;
    if (nextIndex >= progressState.destinations.length) {
      final completedState = progressState.copyWith(
        currentDestinationIndex: progressState.destinations.length,
        estimatedRemainingSeconds: 0,
        remainingDistanceMeters: 0,
        distanceToNextDestinationMeters: null,
        isOffRoute: false,
        navigationMessage: null,
        finishStatus: ActiveMapFinishStatus.prompting,
        finishCountdownSeconds: _finishCountdownSeconds,
        finishPromptDismissed: false,
        finishMessage: null,
        panelState: ActiveMapPanelState.expanded,
      );
      emit(completedState);
      await _persist(completedState);
      return;
    }

    final route = progressState.route!;
    final nextLegIndex = nextIndex - progressState.routeStartDestinationIndex;
    final remainingLegs = nextLegIndex >= 0 && nextLegIndex < route.legs.length
        ? route.legs.skip(nextLegIndex)
        : const Iterable<RouteLeg>.empty();
    final nextState = progressState.copyWith(
      currentDestinationIndex: nextIndex,
      estimatedRemainingSeconds: remainingLegs.fold<int>(
        0,
        (sum, leg) => sum + leg.durationSeconds,
      ),
      remainingDistanceMeters: remainingLegs.fold<double>(
        0,
        (sum, leg) => sum + leg.distanceMeters,
      ),
      distanceToNextDestinationMeters: progressState.userLocation == null
          ? null
          : distanceMeters(
              progressState.userLocation!,
              progressState.destinations[nextIndex].coordinates!,
            ),
      isOffRoute: false,
      navigationMessage: null,
    );
    emit(nextState);
    await _persist(nextState);
  }

  void _requestReroute(Coordinates location, int destinationIndex) {
    if (_isRerouting) {
      return;
    }
    final now = DateTime.now();
    if (_lastRerouteAt != null &&
        now.difference(_lastRerouteAt!) <
            WalkingRouteProgressPolicy.rerouteCooldown) {
      return;
    }
    add(
      _ActiveMapRerouteRequested(
        location: location,
        destinationIndex: destinationIndex,
      ),
    );
  }

  Future<void> _onRerouteRequested(
    _ActiveMapRerouteRequested event,
    Emitter<ActiveMapState> emit,
  ) async {
    if (_isRerouting ||
        event.destinationIndex != state.currentDestinationIndex ||
        event.destinationIndex >= state.destinations.length) {
      return;
    }
    _isRerouting = true;
    _lastRerouteAt = DateTime.now();
    emit(
      state.copyWith(
        isOffRoute: true,
        navigationMessage: 'Updating walking route...',
      ),
    );

    try {
      final remainingDestinations = state.destinations.skip(
        event.destinationIndex,
      );
      final route = await directionsService.calculate([
        event.location,
        for (final destination in remainingDestinations)
          destination.coordinates!,
      ]);
      if (event.destinationIndex != state.currentDestinationIndex) {
        return;
      }
      _offRouteSamples = 0;
      final reroutedState = state.copyWith(
        route: route,
        routeStartDestinationIndex: event.destinationIndex,
        estimatedRemainingSeconds: route.durationSeconds,
        remainingDistanceMeters: route.distanceMeters,
        distanceToNextDestinationMeters: distanceMeters(
          event.location,
          state.destinations[event.destinationIndex].coordinates!,
        ),
        isOffRoute: false,
        navigationMessage: null,
        routeMessage: null,
      );
      emit(reroutedState);
      await _persist(reroutedState);
    } catch (error) {
      emit(
        state.copyWith(
          isOffRoute: true,
          navigationMessage: 'Could not update the walking route.',
        ),
      );
    } finally {
      _isRerouting = false;
    }
  }

  void _onLocationFailed(
    _ActiveMapLocationFailed event,
    Emitter<ActiveMapState> emit,
  ) {
    emit(
      state.copyWith(
        locationMessage: _normalizeLocationErrorMessage(event.message),
      ),
    );
  }

  Future<void> _persist(ActiveMapState value) async {
    if (value.charkh == null || _startedAt == null) {
      return;
    }
    await activeRouteRepository.saveActiveRoute(
      charkhStableId: value.charkh!.stableId,
      startedAt: _startedAt!,
      elapsedSeconds: value.elapsedSeconds,
      etaSeconds: value.estimatedRemainingSeconds,
      currentDestinationIndex: value.currentDestinationIndex,
    );
  }

  Future<void> _recordCompletion(Emitter<ActiveMapState> emit) async {
    if (state.finishStatus == ActiveMapFinishStatus.recorded) {
      return;
    }
    final charkh = state.charkh;
    final startedAt = _startedAt;
    if (charkh == null || startedAt == null) {
      return;
    }

    try {
      final profile = await profileRepository.getProfile();
      final userName = _profileDisplayName(profile.firstName, profile.lastName);
      final elapsedSeconds = state.elapsedSeconds;
      await charkhHistoryRepository.recordCompletedCharkh(
        charkh: charkh,
        userName: userName,
        startedAt: startedAt,
        completedAt: DateTime.now(),
        elapsedSeconds: elapsedSeconds,
        etaSeconds: state.fixedRouteDurationSeconds,
      );
      await activeRouteRepository.clearActiveRoute();
      _timer?.cancel();
      emit(
        state.copyWith(
          elapsedSeconds: elapsedSeconds,
          finishStatus: ActiveMapFinishStatus.recorded,
          finishCountdownSeconds: 0,
          finishMessage: 'Charkh recorded to history.',
          panelState: ActiveMapPanelState.expanded,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(
          finishMessage: error.toString(),
          panelState: ActiveMapPanelState.expanded,
        ),
      );
    }
  }

  @override
  Future<void> close() async {
    _timer?.cancel();
    await _locationSubscription?.cancel();
    await _headingSubscription?.cancel();
    return super.close();
  }
}

_RemainingRouteProgress _remainingRouteProgress({
  required RouteData route,
  required int activeLegIndex,
  required RouteProjection projection,
}) {
  final activeLeg = route.legs[activeLegIndex];
  final remainingFraction = (1 - projection.progress).clamp(0.0, 1.0);
  var distance = activeLeg.distanceMeters * remainingFraction;
  var duration = (activeLeg.durationSeconds * remainingFraction).round();
  for (var i = activeLegIndex + 1; i < route.legs.length; i++) {
    distance += route.legs[i].distanceMeters;
    duration += route.legs[i].durationSeconds;
  }
  return _RemainingRouteProgress(
    distanceMeters: distance,
    durationSeconds: duration,
  );
}

class _RemainingRouteProgress {
  const _RemainingRouteProgress({
    required this.distanceMeters,
    required this.durationSeconds,
  });

  final double distanceMeters;
  final int durationSeconds;
}

const Object _unchanged = Object();

const _minimumHeadingSpeedMetersPerSecond = 0.7;
const _minimumBearingDistanceMeters = 3.0;
const _headingSmoothingFactor = 0.22;
const _compassHeadingSmoothingFactor = 0.42;
const _minimumCompassHeadingDeltaDegrees = 0.6;
const _finishCountdownSeconds = 10;
const _activeRoutePersistenceIntervalSeconds = 5;
const _locationServicesDisabledMessage = 'Location services are disabled.';
const _locationSettingsPromptMessage =
    'Turn on location services, then return to KosCharkh.';

String _normalizeLocationErrorMessage(Object error) {
  final message = error.toString();
  if (message.toLowerCase().contains('location services are disabled')) {
    return _locationServicesDisabledMessage;
  }
  return message;
}

String _profileDisplayName(String firstName, String lastName) {
  final joined = [
    firstName.trim(),
    lastName.trim(),
  ].where((part) => part.isNotEmpty).join(' ');
  return joined.isEmpty ? 'empty' : joined;
}

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
