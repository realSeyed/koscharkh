import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/application/load_status.dart';
import '../data/charkh_repository.dart';
import '../domain/charkh.dart';

class CharkhListState extends Equatable {
  const CharkhListState({
    this.status = LoadStatus.initial,
    this.charkhs = const [],
    this.message,
  });

  final LoadStatus status;
  final List<Charkh> charkhs;
  final String? message;

  CharkhListState copyWith({
    LoadStatus? status,
    List<Charkh>? charkhs,
    String? message,
  }) {
    return CharkhListState(
      status: status ?? this.status,
      charkhs: charkhs ?? this.charkhs,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, charkhs, message];
}

class CharkhListCubit extends Cubit<CharkhListState> {
  CharkhListCubit(this.repository) : super(const CharkhListState());

  final CharkhRepository repository;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      emit(
        state.copyWith(
          status: LoadStatus.loaded,
          charkhs: await repository.getCharkhs(),
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: LoadStatus.failure, message: error.toString()),
      );
    }
  }

  Future<void> delete(String stableId) async {
    await repository.deleteCharkh(stableId);
    await load();
  }
}
