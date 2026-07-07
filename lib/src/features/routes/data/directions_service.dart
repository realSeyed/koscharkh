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
          },
        );

    final response = await _client.get(uri);
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw DirectionsException(
        'Directions request failed: ${response.statusCode}',
      );
    }

    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final routes = json['routes'] as List<dynamic>?;
    if (routes == null || routes.isEmpty) {
      throw DirectionsException('Directions response did not contain a route.');
    }
    final route = routes.first as Map<String, dynamic>;
    final geometry = route['geometry'] as Map<String, dynamic>?;
    final rawPoints = geometry?['coordinates'] as List<dynamic>?;
    if (rawPoints == null || rawPoints.isEmpty) {
      throw DirectionsException(
        'Directions response did not contain geometry.',
      );
    }

    return RouteData(
      points: [
        for (final point in rawPoints)
          LatLng((point as List<dynamic>)[1] as double, point[0] as double),
      ],
      distanceMeters: (route['distance'] as num?)?.toDouble() ?? 0,
      durationSeconds: ((route['duration'] as num?)?.round() ?? 0),
      source: 'mapbox',
    );
  }
}

RouteData buildFallbackRoute({
  required List<Coordinates> coordinates,
  required int timeMinutes,
}) {
  final points = coordinates.map((item) => item.toLatLng()).toList();
  if (points.isEmpty) {
    points.addAll(const [
      LatLng(40.7247, -73.9970),
      LatLng(40.7270, -73.9995),
      LatLng(40.7304, -74.0022),
      LatLng(40.7315, -73.9942),
    ]);
  } else if (points.length == 1) {
    final only = points.single;
    points.add(LatLng(only.latitude + 0.004, only.longitude + 0.003));
  }

  const distance = Distance();
  var totalMeters = 0.0;
  for (var i = 0; i < points.length - 1; i++) {
    totalMeters += distance(points[i], points[i + 1]);
  }

  return RouteData(
    points: points,
    distanceMeters: max(totalMeters, points.length * 300),
    durationSeconds: max(60, timeMinutes * 60),
    source: 'fallback',
  );
}
