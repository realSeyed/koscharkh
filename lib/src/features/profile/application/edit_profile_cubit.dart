import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/application/load_status.dart';
import '../data/profile_repository.dart';
import 'profile_cubit.dart';

class EditProfileCubit extends Cubit<ProfileState> {
  EditProfileCubit(this.repository) : super(const ProfileState()) {
    load();
  }

  final ProfileRepository repository;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    emit(
      state.copyWith(
        status: LoadStatus.loaded,
        profile: await repository.getProfile(),
      ),
    );
  }

  void firstNameChanged(String value) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(firstName: value),
        message: null,
      ),
    );
  }

  void lastNameChanged(String value) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(lastName: value),
        message: null,
      ),
    );
  }

  void ageChanged(String value) {
    emit(
      state.copyWith(
        profile: state.profile.copyWith(age: value),
        message: null,
      ),
    );
  }

  Future<void> save() async {
    if (state.profile.age.trim().isNotEmpty &&
        int.tryParse(state.profile.age.trim()) == null) {
      emit(state.copyWith(message: 'Age must be numeric.'));
      return;
    }
    emit(state.copyWith(status: LoadStatus.saving, message: null));
    await repository.saveProfile(state.profile);
    emit(state.copyWith(status: LoadStatus.saved));
  }
}
