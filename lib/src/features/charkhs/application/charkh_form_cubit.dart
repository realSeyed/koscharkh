import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../../core/application/load_status.dart';
import '../../../core/storage/seed_data.dart';
import '../../destinations/domain/destination.dart';
import '../data/charkh_repository.dart';
import '../domain/charkh.dart';

const _uuid = Uuid();

class CharkhFormState extends Equatable {
  const CharkhFormState({
    this.status = LoadStatus.initial,
    this.stableId,
    this.name = '',
    this.time = '',
    this.description,
    this.destinations = const [],
    this.validationMessage,
    this.createdAt,
  });

  final LoadStatus status;
  final String? stableId;
  final String name;
  final String time;
  final String? description;
  final List<DestinationDraft> destinations;
  final String? validationMessage;
  final DateTime? createdAt;

  int get parsedMinutes => int.tryParse(time.trim()) ?? 0;

  CharkhFormState copyWith({
    LoadStatus? status,
    String? stableId,
    String? name,
    String? time,
    String? description,
    List<DestinationDraft>? destinations,
    Object? validationMessage = _unchanged,
    DateTime? createdAt,
  }) {
    return CharkhFormState(
      status: status ?? this.status,
      stableId: stableId ?? this.stableId,
      name: name ?? this.name,
      time: time ?? this.time,
      description: description ?? this.description,
      destinations: destinations ?? this.destinations,
      validationMessage: validationMessage == _unchanged
          ? this.validationMessage
          : validationMessage as String?,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
    status,
    stableId,
    name,
    time,
    description,
    destinations,
    validationMessage,
    createdAt,
  ];
}

class CharkhFormCubit extends Cubit<CharkhFormState> {
  CharkhFormCubit({required this.repository, this.editStableId})
    : super(const CharkhFormState()) {
    _load();
  }

  final CharkhRepository repository;
  final String? editStableId;

  Future<void> _load() async {
    if (editStableId == null) {
      emit(
        CharkhFormState(
          status: LoadStatus.loaded,
          stableId: 'charkh-${_uuid.v4()}',
          createdAt: DateTime.now(),
        ),
      );
      return;
    }

    emit(state.copyWith(status: LoadStatus.loading));
    final charkh = await repository.getCharkh(editStableId!);
    if (charkh == null) {
      emit(
        state.copyWith(
          status: LoadStatus.failure,
          validationMessage: 'Not found',
        ),
      );
      return;
    }
    emit(
      CharkhFormState(
        status: LoadStatus.loaded,
        stableId: charkh.stableId,
        name: charkh.name,
        time: charkh.timeMinutes.toString(),
        description: charkh.description,
        destinations: charkh.destinations
            .map(DestinationDraft.fromDestination)
            .toList(growable: false),
        createdAt: charkh.createdAt,
      ),
    );
  }

  void nameChanged(String value) {
    emit(state.copyWith(name: value, validationMessage: null));
  }

  void timeChanged(String value) {
    emit(state.copyWith(time: value, validationMessage: null));
  }

  void addDestination(DestinationDraft draft) {
    emit(
      state.copyWith(
        destinations: [...state.destinations, draft],
        validationMessage: null,
      ),
    );
  }

  void updateDestination(DestinationDraft draft) {
    emit(
      state.copyWith(
        destinations: [
          for (final item in state.destinations)
            if (item.stableId == draft.stableId) draft else item,
        ],
      ),
    );
  }

  void removeDestination(String stableId) {
    emit(
      state.copyWith(
        destinations: state.destinations
            .where((item) => item.stableId != stableId)
            .toList(growable: false),
      ),
    );
  }

  Future<void> save() async {
    final name = state.name.trim();
    final minutes = int.tryParse(state.time.trim());
    if (name.isEmpty) {
      emit(state.copyWith(validationMessage: 'Name is required.'));
      return;
    }
    if (minutes == null || minutes <= 0) {
      emit(
        state.copyWith(validationMessage: 'Time must be a positive number.'),
      );
      return;
    }

    emit(state.copyWith(status: LoadStatus.saving, validationMessage: null));
    final stableId = state.stableId ?? 'charkh-${_uuid.v4()}';
    final now = DateTime.now();
    final destinations = [
      for (var i = 0; i < state.destinations.length; i++)
        state.destinations[i].toDestination(
          charkhStableId: stableId,
          position: i,
        ),
    ];
    await repository.saveCharkh(
      Charkh(
        stableId: stableId,
        name: name,
        timeMinutes: minutes,
        description: state.description ?? seedDescription,
        destinations: destinations,
        createdAt: state.createdAt ?? now,
        updatedAt: now,
      ),
    );
    emit(state.copyWith(status: LoadStatus.saved));
  }
}

const Object _unchanged = Object();
