import 'package:flutter_test/flutter_test.dart';
import 'package:koscharkh/src/core/theme/koscharkh_theme.dart';
import 'package:koscharkh/src/core/utils/time_format.dart';
import 'package:koscharkh/src/features/locations/domain/coordinates.dart';
import 'package:koscharkh/src/features/locations/domain/live_user_location.dart';
import 'package:koscharkh/src/features/routes/data/directions_service.dart';
import 'package:koscharkh/src/features/routes/domain/route_data.dart';
import 'package:koscharkh/src/features/routes/domain/walking_route_progress.dart';
import 'package:latlong2/latlong.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('formatClock renders mm:ss values', () {
    expect(formatClock(0), '0:00');
    expect(formatClock(30), '0:30');
    expect(formatClock(1812), '30:12');
    expect(formatClock(-10), '0:00');
  });

  test('fallback route uses supplied coordinates and requested ETA', () {
    final route = buildFallbackRoute(
      coordinates: const [
        Coordinates(latitude: 40.0, longitude: -73.0),
        Coordinates(latitude: 40.1, longitude: -73.2),
      ],
      timeMinutes: 20,
    );

    expect(route.points, hasLength(2));
    expect(route.durationSeconds, 1200);
    expect(route.distanceMeters, greaterThan(0));
    expect(route.source, 'fallback');
    expect(route.legs, hasLength(1));
    expect(route.legs.single.durationSeconds, 1200);
  });

  test('fallback route allocates duration by walking leg distance', () {
    final route = buildFallbackRoute(
      coordinates: const [
        Coordinates(latitude: 0, longitude: 0),
        Coordinates(latitude: 0, longitude: 0.001),
        Coordinates(latitude: 0, longitude: 0.003),
      ],
      timeMinutes: 10,
    );

    expect(route.legs, hasLength(2));
    expect(route.legs[0].durationSeconds, closeTo(200, 1));
    expect(route.legs[1].durationSeconds, closeTo(400, 1));
    expect(
      route.legs.fold<int>(0, (sum, leg) => sum + leg.durationSeconds),
      600,
    );
  });

  test('Mapbox response keeps geometry and timing for each walking leg', () {
    final route = parseMapboxDirectionsResponse(
      {
        'routes': [
          {
            'distance': 210,
            'duration': 160,
            'geometry': {
              'coordinates': [
                [0, 0],
                [0.001, 0],
                [0.002, 0],
              ],
            },
            'legs': [
              {
                'distance': 90,
                'duration': 70,
                'steps': [
                  {
                    'geometry': {
                      'coordinates': [
                        [0, 0],
                        [0.001, 0],
                      ],
                    },
                  },
                ],
              },
              {
                'distance': 120,
                'duration': 90,
                'steps': [
                  {
                    'geometry': {
                      'coordinates': [
                        [0.001, 0],
                        [0.002, 0],
                      ],
                    },
                  },
                ],
              },
            ],
          },
        ],
      },
      const [
        Coordinates(latitude: 0, longitude: 0),
        Coordinates(latitude: 0, longitude: 0.001),
        Coordinates(latitude: 0, longitude: 0.002),
      ],
    );

    expect(route.legs, hasLength(2));
    expect(route.legs[0].points, hasLength(2));
    expect(route.legs[0].durationSeconds, 70);
    expect(route.legs[1].distanceMeters, 120);
  });

  test('fallback route stays empty without enough coordinates', () {
    final emptyRoute = buildFallbackRoute(
      coordinates: const [],
      timeMinutes: 20,
    );
    final singleStopRoute = buildFallbackRoute(
      coordinates: const [Coordinates(latitude: 40.0, longitude: -73.0)],
      timeMinutes: 20,
    );

    expect(emptyRoute.points, isEmpty);
    expect(emptyRoute.durationSeconds, 0);
    expect(singleStopRoute.points, isEmpty);
    expect(singleStopRoute.durationSeconds, 0);
  });

  test('walking projection reports progress along a short route leg', () {
    const leg = RouteLeg(
      points: [LatLng(0, 0), LatLng(0, 0.001)],
      distanceMeters: 111.2,
      durationSeconds: 80,
    );

    final projection = projectLocationOntoLeg(
      location: const Coordinates(latitude: 0.00005, longitude: 0.0005),
      leg: leg,
    );

    expect(projection.progress, closeTo(0.5, 0.01));
    expect(projection.distanceFromRouteMeters, closeTo(5.56, 0.3));
    expect(projection.remainingRouteDistanceMeters, closeTo(55.6, 1));
  });

  test('walking arrival radius stays within pedestrian limits', () {
    expect(WalkingRouteProgressPolicy.arrivalRadius(3), 12);
    expect(WalkingRouteProgressPolicy.arrivalRadius(12), closeTo(14.4, 0.01));
    expect(WalkingRouteProgressPolicy.arrivalRadius(25), 18);
  });

  test('walking progress rejects stale and inaccurate locations', () {
    final now = DateTime(2026, 7, 10, 12);
    final reliable = LiveUserLocation(
      coordinates: const Coordinates(latitude: 40, longitude: -73),
      accuracyMeters: 8,
      timestamp: now.subtract(const Duration(seconds: 5)),
    );
    final stale = LiveUserLocation(
      coordinates: const Coordinates(latitude: 40, longitude: -73),
      accuracyMeters: 8,
      timestamp: now.subtract(const Duration(seconds: 20)),
    );
    final inaccurate = LiveUserLocation(
      coordinates: const Coordinates(latitude: 40, longitude: -73),
      accuracyMeters: 35,
      timestamp: now,
    );

    expect(WalkingRouteProgressPolicy.isReliable(reliable, now: now), isTrue);
    expect(WalkingRouteProgressPolicy.isReliable(stale, now: now), isFalse);
    expect(
      WalkingRouteProgressPolicy.isReliable(inaccurate, now: now),
      isFalse,
    );
  });

  test('dark theme exposes KosCharkh extension tokens', () {
    final theme = buildKoscharkhDarkTheme();

    expect(
      theme.extension<KoscharkhColors>()?.primary,
      koscharkhDarkColors.primary,
    );
    expect(theme.extension<KoscharkhSpacing>()?.xl, 24);
    expect(theme.extension<KoscharkhRadius>()?.pill, 999);
  });
}
