import 'package:equatable/equatable.dart';
import 'package:latlong2/latlong.dart';

class Coordinates extends Equatable {
  const Coordinates({required this.latitude, required this.longitude});

  final double latitude;
  final double longitude;

  LatLng toLatLng() => LatLng(latitude, longitude);

  Coordinates copyWith({double? latitude, double? longitude}) {
    return Coordinates(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  @override
  List<Object?> get props => [latitude, longitude];
}
