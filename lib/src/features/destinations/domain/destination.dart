import 'package:equatable/equatable.dart';

import '../../locations/domain/coordinates.dart';

class Destination extends Equatable {
  const Destination({
    required this.stableId,
    required this.charkhStableId,
    required this.position,
    required this.name,
    required this.description,
    this.coordinates,
    this.address,
  });

  final String stableId;
  final String charkhStableId;
  final int position;
  final String name;
  final String description;
  final Coordinates? coordinates;
  final String? address;

  Destination copyWith({
    String? stableId,
    String? charkhStableId,
    int? position,
    String? name,
    String? description,
    Coordinates? coordinates,
    String? address,
  }) {
    return Destination(
      stableId: stableId ?? this.stableId,
      charkhStableId: charkhStableId ?? this.charkhStableId,
      position: position ?? this.position,
      name: name ?? this.name,
      description: description ?? this.description,
      coordinates: coordinates ?? this.coordinates,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
    stableId,
    charkhStableId,
    position,
    name,
    description,
    coordinates,
    address,
  ];
}

class DestinationDraft extends Equatable {
  const DestinationDraft({
    required this.stableId,
    required this.name,
    required this.description,
    this.coordinates,
    this.address,
  });

  final String stableId;
  final String name;
  final String description;
  final Coordinates? coordinates;
  final String? address;

  factory DestinationDraft.fromDestination(Destination destination) {
    return DestinationDraft(
      stableId: destination.stableId,
      name: destination.name,
      description: destination.description,
      coordinates: destination.coordinates,
      address: destination.address,
    );
  }

  Destination toDestination({
    required String charkhStableId,
    required int position,
  }) {
    return Destination(
      stableId: stableId,
      charkhStableId: charkhStableId,
      position: position,
      name: name,
      description: description,
      coordinates: coordinates,
      address: address,
    );
  }

  DestinationDraft copyWith({
    String? stableId,
    String? name,
    String? description,
    Coordinates? coordinates,
    String? address,
  }) {
    return DestinationDraft(
      stableId: stableId ?? this.stableId,
      name: name ?? this.name,
      description: description ?? this.description,
      coordinates: coordinates ?? this.coordinates,
      address: address ?? this.address,
    );
  }

  @override
  List<Object?> get props => [
    stableId,
    name,
    description,
    coordinates,
    address,
  ];
}
