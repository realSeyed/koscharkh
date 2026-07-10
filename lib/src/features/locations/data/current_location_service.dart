import 'package:geolocator/geolocator.dart';

import '../domain/coordinates.dart';
import '../domain/live_user_location.dart';

class CurrentLocationException implements Exception {
  const CurrentLocationException(this.message);

  final String message;

  @override
  String toString() => message;
}

class CurrentLocationService {
  Future<bool> isLocationServiceEnabled() {
    return Geolocator.isLocationServiceEnabled();
  }

  Future<bool> openLocationSettings() {
    return Geolocator.openLocationSettings();
  }

  Future<Coordinates> getCurrentCoordinates() async {
    final location = await getCurrentLiveLocation();
    return location.coordinates;
  }

  Future<LiveUserLocation> getCurrentLiveLocation() async {
    await _ensureLocationAccess();

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 12),
      ),
    );

    return _toLiveUserLocation(position);
  }

  Future<LiveUserLocation?> getLastKnownLiveLocation() async {
    await _ensureLocationAccess();

    final position = await Geolocator.getLastKnownPosition();
    return position == null ? null : _toLiveUserLocation(position);
  }

  Future<Stream<Coordinates>> watchCoordinates() async {
    final stream = await watchLiveLocation();
    return stream.map((location) => location.coordinates);
  }

  Future<Stream<LiveUserLocation>> watchLiveLocation() async {
    await _ensureLocationAccess();

    return _watchLiveLocation();
  }

  Future<void> _ensureLocationAccess() async {
    final serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw const CurrentLocationException('Location services are disabled.');
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied) {
      throw const CurrentLocationException('Location permission was denied.');
    }
    if (permission == LocationPermission.deniedForever) {
      throw const CurrentLocationException(
        'Location permission is permanently denied.',
      );
    }
  }
}

Stream<LiveUserLocation> _watchLiveLocation() async* {
  final lastKnown = await Geolocator.getLastKnownPosition();
  if (lastKnown != null) {
    yield _toLiveUserLocation(lastKnown);
  }

  yield* Geolocator.getPositionStream(
    locationSettings: const LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 2,
    ),
  ).map(_toLiveUserLocation);
}

LiveUserLocation _toLiveUserLocation(Position position) {
  final heading = position.heading.isFinite && position.heading >= 0
      ? position.heading % 360
      : null;
  final speed = position.speed.isFinite && position.speed >= 0
      ? position.speed
      : 0.0;

  return LiveUserLocation(
    coordinates: Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    ),
    headingDegrees: heading,
    speedMetersPerSecond: speed,
    accuracyMeters: position.accuracy,
    timestamp: position.timestamp,
  );
}
