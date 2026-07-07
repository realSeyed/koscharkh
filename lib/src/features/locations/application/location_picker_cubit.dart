import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/current_location_service.dart';
import '../data/reverse_geocoding_service.dart';
import '../domain/coordinates.dart';
import '../domain/location_selection.dart';

enum AddressStatus { idle, loading, resolved, failure }

enum CurrentLocationStatus { idle, loading, failure }

class LocationPickerState extends Equatable {
  const LocationPickerState({
    required this.coordinates,
    this.address,
    this.addressStatus = AddressStatus.idle,
    this.addressMessage,
    this.currentLocationStatus = CurrentLocationStatus.idle,
    this.currentLocationMessage,
    this.cameraTarget,
    this.cameraMoveId = 0,
  });

  final Coordinates coordinates;
  final String? address;
  final AddressStatus addressStatus;
  final String? addressMessage;
  final CurrentLocationStatus currentLocationStatus;
  final String? currentLocationMessage;
  final Coordinates? cameraTarget;
  final int cameraMoveId;

  LocationSelection get selection {
    return LocationSelection(coordinates: coordinates, address: address);
  }

  bool get isLocating => currentLocationStatus == CurrentLocationStatus.loading;

  LocationPickerState copyWith({
    Coordinates? coordinates,
    Object? address = _unchanged,
    AddressStatus? addressStatus,
    Object? addressMessage = _unchanged,
    CurrentLocationStatus? currentLocationStatus,
    Object? currentLocationMessage = _unchanged,
    Object? cameraTarget = _unchanged,
    int? cameraMoveId,
  }) {
    return LocationPickerState(
      coordinates: coordinates ?? this.coordinates,
      address: address == _unchanged ? this.address : address as String?,
      addressStatus: addressStatus ?? this.addressStatus,
      addressMessage: addressMessage == _unchanged
          ? this.addressMessage
          : addressMessage as String?,
      currentLocationStatus:
          currentLocationStatus ?? this.currentLocationStatus,
      currentLocationMessage: currentLocationMessage == _unchanged
          ? this.currentLocationMessage
          : currentLocationMessage as String?,
      cameraTarget: cameraTarget == _unchanged
          ? this.cameraTarget
          : cameraTarget as Coordinates?,
      cameraMoveId: cameraMoveId ?? this.cameraMoveId,
    );
  }

  @override
  List<Object?> get props => [
    coordinates,
    address,
    addressStatus,
    addressMessage,
    currentLocationStatus,
    currentLocationMessage,
    cameraTarget,
    cameraMoveId,
  ];
}

class LocationPickerCubit extends Cubit<LocationPickerState> {
  LocationPickerCubit({
    required this.reverseGeocodingService,
    required this.currentLocationService,
    LocationSelection? initial,
  }) : super(
         LocationPickerState(
           coordinates:
               initial?.coordinates ??
               const Coordinates(
                 latitude: 33.864783264236,
                 longitude: 53.58459456,
               ),
           address: initial?.address,
           addressStatus: initial?.address == null
               ? AddressStatus.idle
               : AddressStatus.resolved,
         ),
       ) {
    if (initial?.address == null) {
      _scheduleAddressResolve(state.coordinates);
    }
  }

  static const debounceDuration = Duration(milliseconds: 550);

  final ReverseGeocodingService reverseGeocodingService;
  final CurrentLocationService currentLocationService;

  Timer? _debounce;
  int _geocodeRequestId = 0;

  void centerChanged(Coordinates coordinates) {
    if (_isSameCoordinate(coordinates, state.coordinates)) {
      return;
    }
    _geocodeRequestId++;
    emit(
      state.copyWith(
        coordinates: coordinates,
        address: null,
        addressStatus: AddressStatus.idle,
        addressMessage: null,
        currentLocationMessage: null,
      ),
    );
    _scheduleAddressResolve(coordinates);
  }

  Future<void> useCurrentLocation() async {
    if (state.isLocating) {
      return;
    }

    emit(
      state.copyWith(
        currentLocationStatus: CurrentLocationStatus.loading,
        currentLocationMessage: null,
      ),
    );

    try {
      final coordinates = await currentLocationService.getCurrentCoordinates();
      if (isClosed) {
        return;
      }
      _geocodeRequestId++;
      emit(
        state.copyWith(
          coordinates: coordinates,
          address: null,
          addressStatus: AddressStatus.idle,
          addressMessage: null,
          currentLocationStatus: CurrentLocationStatus.idle,
          currentLocationMessage: null,
          cameraTarget: coordinates,
          cameraMoveId: state.cameraMoveId + 1,
        ),
      );
      _scheduleAddressResolve(coordinates, immediate: true);
    } catch (error) {
      if (isClosed) {
        return;
      }
      emit(
        state.copyWith(
          currentLocationStatus: CurrentLocationStatus.failure,
          currentLocationMessage: error.toString(),
        ),
      );
    }
  }

  void _scheduleAddressResolve(
    Coordinates coordinates, {
    bool immediate = false,
  }) {
    _debounce?.cancel();
    final requestId = _geocodeRequestId;
    if (immediate) {
      unawaited(_resolveAddress(coordinates, requestId));
      return;
    }
    _debounce = Timer(debounceDuration, () {
      unawaited(_resolveAddress(coordinates, requestId));
    });
  }

  Future<void> _resolveAddress(Coordinates coordinates, int requestId) async {
    if (isClosed || requestId != _geocodeRequestId) {
      return;
    }
    emit(
      state.copyWith(
        addressStatus: AddressStatus.loading,
        addressMessage: null,
      ),
    );

    try {
      final address = await reverseGeocodingService.resolveAddress(coordinates);
      if (isClosed || requestId != _geocodeRequestId) {
        return;
      }
      emit(
        state.copyWith(
          address: address,
          addressStatus: address == null
              ? AddressStatus.failure
              : AddressStatus.resolved,
          addressMessage: address == null ? 'Address not found.' : null,
        ),
      );
    } catch (error) {
      if (isClosed || requestId != _geocodeRequestId) {
        return;
      }
      emit(
        state.copyWith(
          address: null,
          addressStatus: AddressStatus.failure,
          addressMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    return super.close();
  }
}

bool _isSameCoordinate(Coordinates a, Coordinates b) {
  return (a.latitude - b.latitude).abs() < 0.0000001 &&
      (a.longitude - b.longitude).abs() < 0.0000001;
}

const Object _unchanged = Object();
