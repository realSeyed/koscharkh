import 'dart:async';

import 'package:flutter_compass/flutter_compass.dart';

class CompassHeadingService {
  Stream<double> watchHeadingDegrees() async* {
    final events = FlutterCompass.events;
    if (events == null) {
      return;
    }

    await for (final event in events) {
      final heading = event.heading;
      if (heading == null || !heading.isFinite) {
        continue;
      }
      yield _normalizeDegrees(heading);
    }
  }
}

double _normalizeDegrees(double degrees) {
  final normalized = degrees % 360;
  return normalized < 0 ? normalized + 360 : normalized;
}
