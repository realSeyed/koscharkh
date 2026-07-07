import 'package:isar/isar.dart';
import 'package:latlong2/latlong.dart';

import '../../../core/storage/entities.dart';
import '../domain/route_data.dart';

class RouteCacheRepository {
  RouteCacheRepository(this._isar);

  final Isar _isar;

  Future<RouteData?> getRouteCache(String charkhStableId) async {
    final record = await _isar.routeCacheRecords.getByCharkhStableId(
      charkhStableId,
    );
    if (record == null || record.latitudes.length != record.longitudes.length) {
      return null;
    }
    return RouteData(
      points: [
        for (var i = 0; i < record.latitudes.length; i++)
          LatLng(record.latitudes[i], record.longitudes[i]),
      ],
      distanceMeters: record.distanceMeters,
      durationSeconds: record.durationSeconds,
      source: record.source,
    );
  }

  Future<void> saveRouteCache(String charkhStableId, RouteData route) async {
    final existing = await _isar.routeCacheRecords.getByCharkhStableId(
      charkhStableId,
    );
    await _isar.writeTxn(() async {
      final record = existing ?? RouteCacheRecord();
      record
        ..charkhStableId = charkhStableId
        ..latitudes = route.points.map((item) => item.latitude).toList()
        ..longitudes = route.points.map((item) => item.longitude).toList()
        ..distanceMeters = route.distanceMeters
        ..durationSeconds = route.durationSeconds
        ..source = route.source
        ..updatedAt = DateTime.now();
      await _isar.routeCacheRecords.putByCharkhStableId(record);
    });
  }
}
