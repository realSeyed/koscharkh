import 'package:equatable/equatable.dart';

class CharkhHistory extends Equatable {
  const CharkhHistory({
    required this.stableId,
    required this.charkhStableId,
    required this.charkhName,
    required this.userName,
    required this.startedAt,
    required this.completedAt,
    required this.elapsedSeconds,
    required this.etaSeconds,
    required this.destinationCount,
    this.finalDestinationName,
  });

  final String stableId;
  final String charkhStableId;
  final String charkhName;
  final String userName;
  final DateTime startedAt;
  final DateTime completedAt;
  final int elapsedSeconds;
  final int etaSeconds;
  final int destinationCount;
  final String? finalDestinationName;

  @override
  List<Object?> get props => [
    stableId,
    charkhStableId,
    charkhName,
    userName,
    startedAt,
    completedAt,
    elapsedSeconds,
    etaSeconds,
    destinationCount,
    finalDestinationName,
  ];
}
