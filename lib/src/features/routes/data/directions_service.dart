import 'dart:convert';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';

import '../../../core/config/app_config.dart';
import '../../locations/domain/coordinates.dart';
import '../domain/route_data.dart';

class DirectionsException implements Exception {
  DirectionsException(this.message);

  final String message;

  @override
  String toString() => message;
}

class DirectionsService {
  DirectionsService({http.Client? client}) : _client = client ?? http.Client();

  final http.Client _client;

  Future<RouteData> calculate(List<Coordinates> coordinates) async {
    if (coordinates.length < 2) {
      throw DirectionsException('At least two coordinates are required.');
    }
    if (!AppConfig.hasDirectionsToken) {
      throw DirectionsException('Mapbox access token is not configured.');
    }

    final encodedCoordinates = coordinates
        .map((item) => '${item.longitude},${item.latitude}')
        .join(';');
    final uri =
        Uri.parse(
          '${AppConfig.mapboxDirectionsBaseUrl}/'
          '${AppConfig.mapboxDirectionsProfile}/$encodedCoordinates',
        ).replace(
          queryParameters: {
            'access_token': AppConfig.mapboxAccessToken,
            'geometries': 'geojson',
            'overview': 'full',
            'steps': 'true',
          },
        );

    final response = await _client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw DirectionsException(
        'Directions request failed: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    return parseMapboxDirectionsResponse(json, coordinates);
  }
}

RouteData parseMapboxDirectionsResponse(
  Map<String, dynamic> json,
  List<Coordinates> coordinates,
) {
  final routes = json['routes'] as List<dynamic>?;
  if (routes == null || routes.isEmpty) {
    throw DirectionsException('Directions response did not contain a route.');
  }
  final route = routes.first as Map<String, dynamic>;
  final geometry = route['geometry'] as Map<String, dynamic>?;
  final rawPoints = geometry?['coordinates'] as List<dynamic>?;
  if (rawPoints == null || rawPoints.isEmpty) {
    throw DirectionsException('Directions response did not contain geometry.');
  }

  final points = _parseCoordinates(rawPoints);
  final rawLegs = route['legs'] as List<dynamic>? ?? const [];
  final legs = <RouteLeg>[];
  for (var i = 0; i < coordinates.length - 1; i++) {
    final rawLeg = i < rawLegs.length
        ? rawLegs[i] as Map<String, dynamic>
        : const <String, dynamic>{};
    final legPoints = _parseLegPoints(rawLeg);
    legs.add(
      RouteLeg(
        points: legPoints.length >= 2
            ? legPoints
            : [coordinates[i].toLatLng(), coordinates[i + 1].toLatLng()],
        distanceMeters:
            (rawLeg['distance'] as num?)?.toDouble() ??
            _distanceBetween(coordinates[i], coordinates[i + 1]),
        durationSeconds: (rawLeg['duration'] as num?)?.round() ?? 0,
      ),
    );
  }

  return RouteData(
    points: points,
    distanceMeters: (route['distance'] as num?)?.toDouble() ?? 0,
    durationSeconds: ((route['duration'] as num?)?.round() ?? 0),
    source: 'mapbox',
    legs: legs,
  );
}

RouteData buildFallbackRoute({
  required List<Coordinates> coordinates,
  required int timeMinutes,
}) {
  final points = coordinates.map((item) => item.toLatLng()).toList();
  if (points.length < 2) {
    return const RouteData(
      points: [],
      distanceMeters: 0,
      durationSeconds: 0,
      source: 'fallback',
    );
  }

  const distance = Distance();
  final legDistances = <double>[];
  for (var i = 0; i < points.length - 1; i++) {
    legDistances.add(distance(points[i], points[i + 1]));
  }
  final totalMeters = legDistances.fold<double>(0, (sum, item) => sum + item);
  final totalDurationSeconds = max(60, timeMinutes * 60);
  var allocatedDurationSeconds = 0;
  var cumulativeDistanceMeters = 0.0;
  final legs = <RouteLeg>[];
  for (var i = 0; i < legDistances.length; i++) {
    cumulativeDistanceMeters += legDistances[i];
    final isLast = i == legDistances.length - 1;
    final cumulativeDuration = isLast
        ? totalDurationSeconds
        : totalMeters <= 0
        ? (totalDurationSeconds * (i + 1) / legDistances.length).round()
        : (totalDurationSeconds * cumulativeDistanceMeters / totalMeters)
              .round();
    final duration = max(0, cumulativeDuration - allocatedDurationSeconds);
    allocatedDurationSeconds += duration;
    legs.add(
      RouteLeg(
        points: [points[i], points[i + 1]],
        distanceMeters: legDistances[i],
        durationSeconds: duration,
      ),
    );
  }

  return RouteData(
    points: points,
    distanceMeters: totalMeters,
    durationSeconds: totalDurationSeconds,
    source: 'fallback',
    legs: legs,
  );
}

List<LatLng> _parseCoordinates(List<dynamic> rawPoints) {
  return [
    for (final rawPoint in rawPoints)
      if (rawPoint is List && rawPoint.length >= 2)
        LatLng(
          (rawPoint[1] as num).toDouble(),
          (rawPoint[0] as num).toDouble(),
        ),
  ];
}

List<LatLng> _parseLegPoints(Map<String, dynamic> rawLeg) {
  final points = <LatLng>[];
  final steps = rawLeg['steps'] as List<dynamic>? ?? const [];
  for (final rawStep in steps) {
    if (rawStep is! Map<String, dynamic>) {
      continue;
    }
    final geometry = rawStep['geometry'] as Map<String, dynamic>?;
    final rawCoordinates = geometry?['coordinates'] as List<dynamic>?;
    if (rawCoordinates == null) {
      continue;
    }
    for (final point in _parseCoordinates(rawCoordinates)) {
      if (points.isEmpty || points.last != point) {
        points.add(point);
      }
    }
  }
  return points;
}

double _distanceBetween(Coordinates start, Coordinates end) {
  const distance = Distance();
  return distance(start.toLatLng(), end.toLatLng());
}
