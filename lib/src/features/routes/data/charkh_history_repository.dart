import 'package:isar/isar.dart';
import 'package:uuid/uuid.dart';

import '../../../core/storage/entities.dart';
import '../../charkhs/domain/charkh.dart';
import '../domain/charkh_history.dart';

const _uuid = Uuid();

class CharkhHistoryRepository {
  CharkhHistoryRepository(this._isar);

  final Isar _isar;

  Future<List<CharkhHistory>> getHistory() async {
    final records = await _isar.charkhHistoryRecords.where().findAll();
    records.sort((a, b) => b.completedAt.compareTo(a.completedAt));
    return records.map(_toHistory).toList(growable: false);
  }

  Future<void> recordCompletedCharkh({
    required Charkh charkh,
    required String userName,
    required DateTime startedAt,
    required DateTime completedAt,
    required int elapsedSeconds,
    required int etaSeconds,
  }) async {
    await _isar.writeTxn(() async {
      await _isar.charkhHistoryRecords.putByStableId(
        CharkhHistoryRecord()
          ..stableId = 'history-${_uuid.v4()}'
          ..charkhStableId = charkh.stableId
          ..charkhName = charkh.name
          ..userName = userName
          ..startedAt = startedAt
          ..completedAt = completedAt
          ..elapsedSeconds = elapsedSeconds
          ..etaSeconds = etaSeconds
          ..destinationCount = charkh.destinations.length
          ..finalDestinationName = charkh.destinations.isEmpty
              ? null
              : charkh.destinations.last.name,
      );
    });
  }

  CharkhHistory _toHistory(CharkhHistoryRecord record) {
    return CharkhHistory(
      stableId: record.stableId,
      charkhStableId: record.charkhStableId,
      charkhName: record.charkhName,
      userName: record.userName,
      startedAt: record.startedAt,
      completedAt: record.completedAt,
      elapsedSeconds: record.elapsedSeconds,
      etaSeconds: record.etaSeconds,
      destinationCount: record.destinationCount,
      finalDestinationName: record.finalDestinationName,
    );
  }
}
