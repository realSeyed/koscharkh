import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/application/load_status.dart';
import '../../../core/storage/seed_data.dart';
import '../../routes/data/charkh_history_repository.dart';
import '../../routes/domain/charkh_history.dart';
import '../data/profile_repository.dart';
import '../domain/profile.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.status = LoadStatus.initial,
    this.profile = seedProfile,
    this.history = const [],
    this.message,
  });

  final LoadStatus status;
  final Profile profile;
  final List<CharkhHistory> history;
  final String? message;

  ProfileState copyWith({
    LoadStatus? status,
    Profile? profile,
    List<CharkhHistory>? history,
    Object? message = _unchanged,
  }) {
    return ProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      history: history ?? this.history,
      message: message == _unchanged ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => [status, profile, history, message];
}

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.profileRepository,
    required this.charkhHistoryRepository,
  }) : super(const ProfileState());

  final ProfileRepository profileRepository;
  final CharkhHistoryRepository charkhHistoryRepository;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      emit(
        state.copyWith(
          status: LoadStatus.loaded,
          profile: await profileRepository.getProfile(),
          history: await charkhHistoryRepository.getHistory(),
          message: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: LoadStatus.failure, message: error.toString()),
      );
    }
  }
}

const Object _unchanged = Object();
