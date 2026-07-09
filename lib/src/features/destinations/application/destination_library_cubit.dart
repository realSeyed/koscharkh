import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/application/load_status.dart';
import '../data/destination_library_repository.dart';
import '../domain/destination.dart';

class DestinationLibraryState extends Equatable {
  const DestinationLibraryState({
    this.status = LoadStatus.initial,
    this.destinations = const [],
    this.message,
  });

  final LoadStatus status;
  final List<DestinationDraft> destinations;
  final String? message;

  DestinationLibraryState copyWith({
    LoadStatus? status,
    List<DestinationDraft>? destinations,
    Object? message = _unchanged,
  }) {
    return DestinationLibraryState(
      status: status ?? this.status,
      destinations: destinations ?? this.destinations,
      message: message == _unchanged ? this.message : message as String?,
    );
  }

  @override
  List<Object?> get props => [status, destinations, message];
}

class DestinationLibraryCubit extends Cubit<DestinationLibraryState> {
  DestinationLibraryCubit(this.repository)
    : super(const DestinationLibraryState());

  final DestinationLibraryRepository repository;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      emit(
        state.copyWith(
          status: LoadStatus.loaded,
          destinations: await repository.getSavedDestinations(),
          message: null,
        ),
      );
    } catch (error) {
      emit(
        state.copyWith(status: LoadStatus.failure, message: error.toString()),
      );
    }
  }

  Future<void> saveDestination(DestinationDraft destination) async {
    emit(state.copyWith(status: LoadStatus.saving));
    try {
      await repository.saveDestination(destination);
      await load();
    } catch (error) {
      emit(
        state.copyWith(status: LoadStatus.failure, message: error.toString()),
      );
    }
  }

  Future<void> deleteDestination(String stableId) async {
    emit(state.copyWith(status: LoadStatus.saving));
    try {
      await repository.deleteDestination(stableId);
      await load();
    } catch (error) {
      emit(
        state.copyWith(status: LoadStatus.failure, message: error.toString()),
      );
    }
  }
}

const Object _unchanged = Object();
