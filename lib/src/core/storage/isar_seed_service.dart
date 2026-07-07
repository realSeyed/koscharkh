import 'package:isar/isar.dart';

import 'entities.dart';
import 'seed_data.dart';

class IsarSeedService {
  IsarSeedService(this._isar);

  final Isar _isar;

  Future<void> seedIfEmpty() async {
    final existingCharkhs = await _isar.charkhRecords.count();
    if (existingCharkhs > 0) {
      return;
    }

    final now = DateTime.now();
    await _isar.writeTxn(() async {
      await _isar.profileRecords.put(
        ProfileRecord()
          ..id = 1
          ..firstName = seedProfile.firstName
          ..lastName = seedProfile.lastName
          ..age = seedProfile.age,
      );

      for (var i = 0; i < 3; i++) {
        final stableId = 'charkh-${i + 1}';
        await _isar.charkhRecords.putByStableId(
          CharkhRecord()
            ..stableId = stableId
            ..name = ['First Charkh', 'Second Charkh', 'Third Charkh'][i]
            ..timeMinutes = 20
            ..description = seedDescription
            ..createdAt = now.subtract(Duration(minutes: 3 - i))
            ..updatedAt = now.subtract(Duration(minutes: 3 - i)),
        );

        for (var index = 0; index < seedDestinationTemplates.length; index++) {
          final template = seedDestinationTemplates[index];
          await _isar.destinationRecords.putByStableId(
            DestinationRecord()
              ..stableId = '$stableId-${template.stableId}'
              ..charkhStableId = stableId
              ..position = index
              ..name = template.name
              ..description = template.description
              ..latitude = template.coordinates?.latitude
              ..longitude = template.coordinates?.longitude
              ..address = template.address,
          );
        }
      }
    });
  }
}
