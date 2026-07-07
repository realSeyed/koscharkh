import 'package:isar/isar.dart';

import '../../../core/storage/entities.dart';

class ActiveRouteRepository {
  ActiveRouteRepository(this._isar);

  final Isar _isar;

  Future<void> saveActiveRoute({
    required String charkhStableId,
    required DateTime startedAt,
    required int elapsedSeconds,
    required int etaSeconds,
    required int currentDestinationIndex,
  }) async {
    await _isar.writeTxn(() async {
      final record =
          (await _isar.activeRouteRecords.get(1)) ?? ActiveRouteRecord();
      record
        ..id = 1
        ..charkhStableId = charkhStableId
        ..startedAt = startedAt
        ..elapsedSeconds = elapsedSeconds
        ..etaSeconds = etaSeconds
        ..currentDestinationIndex = currentDestinationIndex;
      await _isar.activeRouteRecords.put(record);
    });
  }
}
