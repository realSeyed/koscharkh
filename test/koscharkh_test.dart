import 'package:flutter_test/flutter_test.dart';
import 'package:koscharkh/src/core/theme/koscharkh_theme.dart';
import 'package:koscharkh/src/core/utils/time_format.dart';
import 'package:koscharkh/src/features/locations/domain/coordinates.dart';
import 'package:koscharkh/src/features/routes/data/directions_service.dart';

void main() {
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
