import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class RouteData extends Equatable {
  const RouteData({
    required this.points,
    required this.distanceMeters,
    required this.durationSeconds,
    required this.source,
  });

  final List<LatLng> points;
  final double distanceMeters;
  final int durationSeconds;
  final String source;

  @override
  List<Object?> get props => [points, distanceMeters, durationSeconds, source];
}
