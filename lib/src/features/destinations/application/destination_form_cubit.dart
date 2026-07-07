import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../locations/domain/location_selection.dart';
import '../domain/destination.dart';

const _uuid = Uuid();

class DestinationFormState extends Equatable {
  const DestinationFormState({
    this.name = '',
    this.description = '',
    this.stableId,
    this.location,
    this.validationMessage,
    this.submittedDraft,
  });

  final String name;
  final String description;
  final String? stableId;
  final LocationSelection? location;
  final String? validationMessage;
  final DestinationDraft? submittedDraft;

  DestinationFormState copyWith({
    String? name,
    String? description,
    String? stableId,
    LocationSelection? location,
    Object? validationMessage = _unchanged,
    DestinationDraft? submittedDraft,
  }) {
    return DestinationFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      stableId: stableId ?? this.stableId,
      location: location ?? this.location,
      validationMessage: validationMessage == _unchanged
          ? this.validationMessage
          : validationMessage as String?,
      submittedDraft: submittedDraft,
    );
  }

  @override
  List<Object?> get props => [
    name,
    description,
    stableId,
    location,
    validationMessage,
    submittedDraft,
  ];
}

class DestinationFormCubit extends Cubit<DestinationFormState> {
  DestinationFormCubit(DestinationDraft? draft)
    : super(
        DestinationFormState(
          name: draft?.name ?? '',
          description: draft?.description ?? '',
          stableId: draft?.stableId ?? 'dest-${_uuid.v4()}',
          location: draft?.coordinates == null
              ? null
              : LocationSelection(
                  coordinates: draft!.coordinates!,
                  address: draft.address,
                ),
        ),
      );

  void nameChanged(String value) {
    emit(state.copyWith(name: value, validationMessage: null));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value, validationMessage: null));
  }

  void locationChanged(LocationSelection selection) {
    emit(state.copyWith(location: selection, validationMessage: null));
  }

  void submit() {
    if (state.name.trim().isEmpty) {
      emit(state.copyWith(validationMessage: 'Name is required.'));
      return;
    }
    emit(
      state.copyWith(
        validationMessage: null,
        submittedDraft: DestinationDraft(
          stableId: state.stableId ?? 'dest-${_uuid.v4()}',
          name: state.name.trim(),
          description: state.description.trim(),
          coordinates: state.location?.coordinates,
          address: state.location?.address,
        ),
      ),
    );
  }
}

const Object _unchanged = Object();
