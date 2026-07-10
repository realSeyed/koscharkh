import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteData extends Equatable {
  const RouteData({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.source,
    this.legs = const [],
  });

  final List<LatLng> points;
  final double distanceMeters;
  final int durationSeconds;
  final String source;
  final List<RouteLeg> legs;

  @override
  List<Object?> get props => [
    points,
    distanceMeters,
    durationSeconds,
    source,
    legs,
  ];
}

class RouteLeg extends Equatable {
  const RouteLeg({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
  });

  final List<LatLng> points;
  final double distanceMeters;
  final int durationSeconds;

  @override
  List<Object?> get props => [points, distanceMeters, durationSeconds];
}
