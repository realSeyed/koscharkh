import 'package:isar/isar.dart';

part 'entities.g.dart';

@collection
class ProfileRecord {
  Id id = 1;
  String firstName = '';
  String lastName = '';
  String age = '';
}

@collection
class CharkhRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String stableId;

  late String name;
  int timeMinutes = 0;
  String? description;
  late DateTime createdAt;
  late DateTime updatedAt;
}

@collection
class DestinationRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String stableId;

  @Index()
  late String charkhStableId;

  int position = 0;
  late String name;
  late String description;
  double? latitude;
  double? longitude;
  String? address;
}

@collection
class SavedDestinationRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String stableId;

  late String name;
  late String description;
  double? latitude;
  double? longitude;
  String? address;
  late DateTime createdAt;
  late DateTime updatedAt;
}

@collection
class RouteCacheRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String charkhStableId;

  List<double> latitudes = [];
  List<double> longitudes = [];
  double distanceMeters = 0;
  int durationSeconds = 0;
  late String source;
  late DateTime updatedAt;
}

@collection
class ActiveRouteRecord {
  Id id = 1;
  late String charkhStableId;
  late DateTime startedAt;
  int elapsedSeconds = 0;
  int etaSeconds = 0;
  int currentDestinationIndex = 0;
}

@collection
class CharkhHistoryRecord {
  Id id = Isar.autoIncrement;

  @Index(unique: true, replace: true)
  late String stableId;

  @Index()
  late String charkhStableId;

  late String charkhName;
  late String userName;
  late DateTime startedAt;
  late DateTime completedAt;
  int elapsedSeconds = 0;
  int etaSeconds = 0;
  int destinationCount = 0;
  String? finalDestinationName;
}
