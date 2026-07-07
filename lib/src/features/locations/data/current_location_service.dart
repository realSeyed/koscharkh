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
  Future<Coordinates> getCurrentCoordinates() async {
    await _ensureLocationAccess();

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        timeLimit: Duration(seconds: 12),
      ),
    );

    return Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  Future<Stream<Coordinates>> watchCoordinates() async {
    final stream = await watchLiveLocation();
    return stream.map((location) => location.coordinates);
  }

  Future<Stream<LiveUserLocation>> watchLiveLocation() async {
    await _ensureLocationAccess();

    return Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 2,
      ),
    ).map(_toLiveUserLocation);
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
  );
}
