import 'package:equatable/equatable.dart';

import 'coordinates.dart';

class LiveUserLocation extends Equatable {
  const LiveUserLocation({
    required this.coordinates,
    this.headingDegrees,
    this.speedMetersPerSecond = 0,
    this.accuracyMeters = 0,
    this.timestamp,
  });

  final Coordinates coordinates;
  final double? headingDegrees;
  final double speedMetersPerSecond;
  final double accuracyMeters;
  final DateTime? timestamp;

  @override
  List<Object?> get props => [
    coordinates,
    headingDegrees,
    speedMetersPerSecond,
    accuracyMeters,
    timestamp,
  ];
}
