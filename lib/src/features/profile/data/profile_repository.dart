import 'package:isar/isar.dart';

import '../../../core/storage/entities.dart';
import '../../../core/storage/seed_data.dart';
import '../domain/profile.dart';

class ProfileRepository {
  ProfileRepository(this._isar);

  final Isar _isar;

  Future<Profile> getProfile() async {
    final record = await _isar.profileRecords.get(1);
    if (record == null) {
      return seedProfile;
    }
    return Profile(
      firstName: record.firstName,
      lastName: record.lastName,
      age: record.age,
    );
  }

  Future<void> saveProfile(Profile profile) async {
    await _isar.writeTxn(() async {
      final record = (await _isar.profileRecords.get(1)) ?? ProfileRecord();
      record
        ..id = 1
        ..firstName = profile.firstName
        ..lastName = profile.lastName
        ..age = profile.age;
      await _isar.profileRecords.put(record);
    });
  }
}
