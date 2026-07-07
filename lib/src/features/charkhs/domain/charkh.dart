import 'package:equatable/equatable.dart';

import '../../destinations/domain/destination.dart';

class Charkh extends Equatable {
  const Charkh({
    required this.stableId,
    required this.name,
    required this.timeMinutes,
    required this.destinations,
    required this.createdAt,
    required this.updatedAt,
    this.description,
  });

  final String stableId;
  final String name;
  final int timeMinutes;
  final String? description;
  final List<Destination> destinations;
  final DateTime createdAt;
  final DateTime updatedAt;

  Charkh copyWith({
    String? stableId,
    String? name,
    int? timeMinutes,
    String? description,
    List<Destination>? destinations,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Charkh(
      stableId: stableId ?? this.stableId,
      name: name ?? this.name,
      timeMinutes: timeMinutes ?? this.timeMinutes,
      description: description ?? this.description,
      destinations: destinations ?? this.destinations,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  List<Object?> get props => [
    stableId,
    name,
    timeMinutes,
    description,
    destinations,
    createdAt,
    updatedAt,
  ];
}
