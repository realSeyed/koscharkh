import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/application/load_status.dart';
import '../../../core/storage/seed_data.dart';
import '../data/profile_repository.dart';
import '../domain/profile.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = LoadStatus.initial,
    this.profile = seedProfile,
    this.message,
  });

  final LoadStatus status;
  final Profile profile;
  final String? message;

  ProfileState copyWith({
    LoadStatus? status,
    Profile? profile,
    String? message,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, profile, message];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit(this.repository) : super(const ProfileState());

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
}
