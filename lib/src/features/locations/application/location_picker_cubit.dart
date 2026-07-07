import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../domain/coordinates.dart';
import '../domain/location_selection.dart';

class LocationPickerState extends Equatable {
  const LocationPickerState({required this.selection});

  final LocationSelection selection;

  @override
  List<Object?> get props => [selection];
}

class LocationPickerCubit extends Cubit<LocationPickerState> {
  LocationPickerCubit(LocationSelection? initial)
    : super(
        LocationPickerState(
          selection:
              initial ??
              const LocationSelection(
                coordinates: Coordinates(
                  latitude: 33.864783264236,
                  longitude: 53.58459456,
                ),
                address: 'Singer Building, ............',
              ),
        ),
      );

  void select(Coordinates coordinates) {
    emit(
      LocationPickerState(
        selection: LocationSelection(
          coordinates: coordinates,
          address: 'Selected location',
        ),
      ),
    );
  }

  void recenter() {
    select(
      const Coordinates(latitude: 33.864783264236, longitude: 53.58459456),
    );
  }
}
