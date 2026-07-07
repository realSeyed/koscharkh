import 'package:equatable/equatable.dart';

import 'coordinates.dart';

class LiveUserLocation extends Equatable {
  const LiveUserLocation({
    required this.coordinates,
    this.headingDegrees,
    this.speedMetersPerSecond = 0,
  });

  final Coordinates coordinates;
  final double? headingDegrees;
  final double speedMetersPerSecond;

  @override
  List<Object?> get props => [
    coordinates,
    headingDegrees,
    speedMetersPerSecond,
  ];
}
