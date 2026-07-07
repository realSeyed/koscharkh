import 'package:equatable/equatable.dart';

import 'coordinates.dart';

class LocationSelection extends Equatable {
  const LocationSelection({required this.coordinates, this.address});

  final Coordinates coordinates;
  final String? address;

  @override
  List<Object?> get props => [coordinates, address];
}
