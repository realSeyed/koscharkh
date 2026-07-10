import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

import '../../locations/domain/coordinates.dart';
import '../../locations/domain/live_user_location.dart';
import 'route_data.dart';

class RouteProjection extends Equatable {
  const RouteProjection({
    required this.distanceFromRouteMeters,
    required this.distanceAlongRouteMeters,
    required this.remainingRouteDistanceMeters,
    required this.progress,
  });

  final double distanceFromRouteMeters;
  final double distanceAlongRouteMeters;
  final double remainingRouteDistanceMeters;
  final double progress;

  @override
  List<Object?> get props => [
    distanceFromRouteMeters,
    distanceAlongRouteMeters,
    remainingRouteDistanceMeters,
    progress,
  ];
}

class WalkingRouteProgressPolicy {
  const WalkingRouteProgressPolicy._();

  static const double minimumArrivalRadiusMeters = 12;
  static const double maximumArrivalRadiusMeters = 18;
  static const double arrivalExitRadiusMeters = 24;
  static const double endpointPassRadiusMeters = 22;
  static const double endpointRemainingDistanceMeters = 5;
  static const double maximumReliableAccuracyMeters = 25;
  static const double offRouteDistanceMeters = 30;
  static const int arrivalConfirmationSamples = 2;
  static const int offRouteConfirmationSamples = 3;
  static const Duration maximumLocationAge = Duration(seconds: 12);
  static const Duration rerouteCooldown = Duration(seconds: 12);

  static bool isReliable(LiveUserLocation location, {required DateTime now}) {
    if (!location.accuracyMeters.isFinite ||
        location.accuracyMeters < 0 ||
        location.accuracyMeters > maximumReliableAccuracyMeters) {
      return false;
    }
    final timestamp = location.timestamp;
    if (timestamp == null) {
      return true;
    }
    final age = now.difference(timestamp);
    return age <= maximumLocationAge && age >= -maximumLocationAge;
  }

  static double arrivalRadius(double accuracyMeters) {
    return (accuracyMeters * 1.2).clamp(
      minimumArrivalRadiusMeters,
      maximumArrivalRadiusMeters,
    );
  }

  static double offRouteThreshold(double accuracyMeters) {
    return max(offRouteDistanceMeters, accuracyMeters * 1.5);
  }
}

RouteProjection projectLocationOntoLeg({
  required Coordinates location,
  required RouteLeg leg,
}) {
  final points = leg.points;
  if (points.isEmpty) {
    return const RouteProjection(
      distanceFromRouteMeters: double.infinity,
      distanceAlongRouteMeters: 0,
      remainingRouteDistanceMeters: 0,
      progress: 0,
    );
  }
  if (points.length == 1) {
    final distance = distanceMeters(
      location,
      Coordinates(
        latitude: points.first.latitude,
        longitude: points.first.longitude,
      ),
    );
    return RouteProjection(
      distanceFromRouteMeters: distance,
      distanceAlongRouteMeters: 0,
      remainingRouteDistanceMeters: distance,
      progress: 0,
    );
  }

  final localPoints = points
      .map((point) => _toLocalMeters(point, location))
      .toList(growable: false);
  final segmentLengths = <double>[];
  var totalLength = 0.0;
  for (var i = 0; i < localPoints.length - 1; i++) {
    final length = (localPoints[i + 1] - localPoints[i]).length;
    segmentLengths.add(length);
    totalLength += length;
  }

  var closestDistance = double.infinity;
  var closestAlongDistance = 0.0;
  var traversedDistance = 0.0;
  for (var i = 0; i < segmentLengths.length; i++) {
    final start = localPoints[i];
    final end = localPoints[i + 1];
    final segment = end - start;
    final squaredLength = segment.squaredLength;
    final t = squaredLength == 0
        ? 0.0
        : ((-start.x * segment.x - start.y * segment.y) / squaredLength).clamp(
            0.0,
            1.0,
          );
    final projected = start + segment.scale(t);
    final distance = projected.length;
    if (distance < closestDistance) {
      closestDistance = distance;
      closestAlongDistance = traversedDistance + segmentLengths[i] * t;
    }
    traversedDistance += segmentLengths[i];
  }

  final progress = totalLength <= 0
      ? 0.0
      : (closestAlongDistance / totalLength).clamp(0.0, 1.0);
  return RouteProjection(
    distanceFromRouteMeters: closestDistance,
    distanceAlongRouteMeters: closestAlongDistance,
    remainingRouteDistanceMeters: max(0, totalLength - closestAlongDistance),
    progress: progress,
  );
}

double distanceMeters(Coordinates a, Coordinates b) {
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

_LocalPoint _toLocalMeters(LatLng point, Coordinates origin) {
  const earthRadiusMeters = 6371000.0;
  final latitudeRadians = _degreesToRadians(origin.latitude);
  return _LocalPoint(
    _degreesToRadians(point.longitude - origin.longitude) *
        cos(latitudeRadians) *
        earthRadiusMeters,
    _degreesToRadians(point.latitude - origin.latitude) * earthRadiusMeters,
  );
}

double _degreesToRadians(double degrees) => degrees * pi / 180;

class _LocalPoint {
  const _LocalPoint(this.x, this.y);

  final double x;
  final double y;

  double get length => sqrt(squaredLength);
  double get squaredLength => x * x + y * y;

  _LocalPoint operator -(_LocalPoint other) =>
      _LocalPoint(x - other.x, y - other.y);

  _LocalPoint operator +(_LocalPoint other) =>
      _LocalPoint(x + other.x, y + other.y);

  _LocalPoint scale(double factor) => _LocalPoint(x * factor, y * factor);
}
