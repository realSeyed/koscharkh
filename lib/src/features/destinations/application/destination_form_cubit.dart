import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

import '../../locations/domain/location_selection.dart';
import '../data/destination_library_repository.dart';
import '../domain/destination.dart';

const _uuid = Uuid();

class DestinationFormState extends Equatable {
  const DestinationFormState({
    this.name = '',
    this.description = '',
    this.stableId,
    this.location,
    this.canSaveToLibrary = false,
    this.saveToLibrary = false,
    this.validationMessage,
    this.submittedDraft,
  });

  final String name;
  final String description;
  final String? stableId;
  final LocationSelection? location;
  final bool canSaveToLibrary;
  final bool saveToLibrary;
  final String? validationMessage;
  final DestinationDraft? submittedDraft;

  DestinationFormState copyWith({
    String? name,
    String? description,
    String? stableId,
    LocationSelection? location,
    bool? canSaveToLibrary,
    bool? saveToLibrary,
    Object? validationMessage = _unchanged,
    DestinationDraft? submittedDraft,
  }) {
    return DestinationFormState(
      name: name ?? this.name,
      description: description ?? this.description,
      stableId: stableId ?? this.stableId,
      location: location ?? this.location,
      canSaveToLibrary: canSaveToLibrary ?? this.canSaveToLibrary,
      saveToLibrary: saveToLibrary ?? this.saveToLibrary,
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
    canSaveToLibrary,
    saveToLibrary,
    validationMessage,
    submittedDraft,
  ];
}

class DestinationFormCubit extends Cubit<DestinationFormState> {
  DestinationFormCubit(
    DestinationDraft? draft, {
    this.destinationLibraryRepository,
    bool canSaveToLibrary = false,
  }) : super(
         DestinationFormState(
           name: draft?.name ?? '',
           description: draft?.description ?? '',
           stableId: draft?.stableId ?? 'dest-${_uuid.v4()}',
           canSaveToLibrary: canSaveToLibrary,
           location: draft?.coordinates == null
               ? null
               : LocationSelection(
                   coordinates: draft!.coordinates!,
                   address: draft.address,
                 ),
         ),
       );

  final DestinationLibraryRepository? destinationLibraryRepository;

  void nameChanged(String value) {
    emit(state.copyWith(name: value, validationMessage: null));
  }

  void descriptionChanged(String value) {
    emit(state.copyWith(description: value, validationMessage: null));
  }

  void locationChanged(LocationSelection selection) {
    emit(state.copyWith(location: selection, validationMessage: null));
  }

  void saveToLibraryChanged(bool value) {
    emit(state.copyWith(saveToLibrary: value, validationMessage: null));
  }

  Future<void> submit() async {
    if (state.name.trim().isEmpty) {
      emit(state.copyWith(validationMessage: 'Name is required.'));
      return;
    }
    final draft = DestinationDraft(
      stableId: state.stableId ?? 'dest-${_uuid.v4()}',
      name: state.name.trim(),
      description: state.description.trim(),
      coordinates: state.location?.coordinates,
      address: state.location?.address,
    );

    if (state.saveToLibrary) {
      final repository = destinationLibraryRepository;
      if (repository == null) {
        emit(
          state.copyWith(
            validationMessage: 'Saved destinations are unavailable.',
          ),
        );
        return;
      }
      try {
        await repository.saveDestination(
          draft.copyWith(stableId: 'saved-dest-${_uuid.v4()}'),
        );
      } catch (error) {
        emit(state.copyWith(validationMessage: error.toString()));
        return;
      }
    }

    emit(state.copyWith(validationMessage: null, submittedDraft: draft));
  }
}

const Object _unchanged = Object();
