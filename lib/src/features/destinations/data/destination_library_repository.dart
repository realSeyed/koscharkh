import 'package:isar/isar.dart';

import '../../../core/storage/entities.dart';
import '../../locations/domain/coordinates.dart';
import '../domain/destination.dart';

class DestinationLibraryRepository {
  DestinationLibraryRepository(this._isar);

  final Isar _isar;

  Future<List<DestinationDraft>> getSavedDestinations() async {
    final records = await _isar.savedDestinationRecords.where().findAll();
    records.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    return records.map(_toDraft).toList(growable: false);
  }

  Future<DestinationDraft?> getSavedDestination(String stableId) async {
    final record = await _isar.savedDestinationRecords.getByStableId(stableId);
    return record == null ? null : _toDraft(record);
  }

  Future<void> saveDestination(DestinationDraft destination) async {
    final now = DateTime.now();
    final existing = await _isar.savedDestinationRecords.getByStableId(
      destination.stableId,
    );
    await _isar.writeTxn(() async {
      final record = existing ?? SavedDestinationRecord();
      record
        ..stableId = destination.stableId
        ..name = destination.name
        ..description = destination.description
        ..latitude = destination.coordinates?.latitude
        ..longitude = destination.coordinates?.longitude
        ..address = destination.address
        ..createdAt = existing?.createdAt ?? now
        ..updatedAt = now;
      await _isar.savedDestinationRecords.putByStableId(record);
    });
  }

  Future<void> deleteDestination(String stableId) async {
    await _isar.writeTxn(() async {
      await _isar.savedDestinationRecords.deleteByStableId(stableId);
    });
  }

  DestinationDraft _toDraft(SavedDestinationRecord record) {
    return DestinationDraft(
      stableId: record.stableId,
      name: record.name,
      description: record.description,
      coordinates: record.latitude == null || record.longitude == null
          ? null
          : Coordinates(
              latitude: record.latitude!,
              longitude: record.longitude!,
            ),
      address: record.address,
    );
  }
}
