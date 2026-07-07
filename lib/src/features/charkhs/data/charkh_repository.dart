import 'package:isar/isar.dart';

import '../../../core/storage/entities.dart';
import '../../destinations/domain/destination.dart';
import '../../locations/domain/coordinates.dart';
import '../domain/charkh.dart';

class CharkhRepository {
  CharkhRepository(this._isar);

  final Isar _isar;

  Future<List<Charkh>> getCharkhs() async {
    final records = await _isar.charkhRecords.where().findAll();
    records.sort((a, b) => a.createdAt.compareTo(b.createdAt));
    final charkhs = <Charkh>[];
    for (final record in records) {
      charkhs.add(await _toCharkh(record));
    }
    return charkhs;
  }

  Future<Charkh?> getCharkh(String stableId) async {
    final record = await _isar.charkhRecords.getByStableId(stableId);
    if (record == null) {
      return null;
    }
    return _toCharkh(record);
  }

  Future<void> saveCharkh(Charkh charkh) async {
    final existing = await _isar.charkhRecords.getByStableId(charkh.stableId);
    final existingDestinations = await _destinationRecordsFor(charkh.stableId);
    await _isar.writeTxn(() async {
      final record = existing ?? CharkhRecord();
      record
        ..stableId = charkh.stableId
        ..name = charkh.name
        ..timeMinutes = charkh.timeMinutes
        ..description = charkh.description
        ..createdAt = existing?.createdAt ?? charkh.createdAt
        ..updatedAt = DateTime.now();
      await _isar.charkhRecords.putByStableId(record);

      await _isar.destinationRecords.deleteAll(
        existingDestinations.map((item) => item.id).toList(),
      );
      for (final destination in charkh.destinations) {
        await _isar.destinationRecords.putByStableId(
          DestinationRecord()
            ..stableId = destination.stableId
            ..charkhStableId = destination.charkhStableId
            ..position = destination.position
            ..name = destination.name
            ..description = destination.description
            ..latitude = destination.coordinates?.latitude
            ..longitude = destination.coordinates?.longitude
            ..address = destination.address,
        );
      }
    });
  }

  Future<void> deleteCharkh(String stableId) async {
    final destinationRecords = await _destinationRecordsFor(stableId);
    await _isar.writeTxn(() async {
      await _isar.charkhRecords.deleteByStableId(stableId);
      await _isar.destinationRecords.deleteAll(
        destinationRecords.map((item) => item.id).toList(),
      );
      await _isar.routeCacheRecords.deleteByCharkhStableId(stableId);
    });
  }

  Future<List<Destination>> getDestinations(String charkhStableId) async {
    final records = await _destinationRecordsFor(charkhStableId);
    records.sort((a, b) => a.position.compareTo(b.position));
    return records.map(_toDestination).toList();
  }

  Future<Charkh> _toCharkh(CharkhRecord record) async {
    return Charkh(
      stableId: record.stableId,
      name: record.name,
      timeMinutes: record.timeMinutes,
      description: record.description,
      destinations: await getDestinations(record.stableId),
      createdAt: record.createdAt,
      updatedAt: record.updatedAt,
    );
  }

  Future<List<DestinationRecord>> _destinationRecordsFor(
    String charkhStableId,
  ) {
    return _isar.destinationRecords
        .where()
        .charkhStableIdEqualTo(charkhStableId)
        .findAll();
  }

  Destination _toDestination(DestinationRecord record) {
    return Destination(
      stableId: record.stableId,
      charkhStableId: record.charkhStableId,
      position: record.position,
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
