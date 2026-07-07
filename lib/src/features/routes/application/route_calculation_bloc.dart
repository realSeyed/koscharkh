import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../destinations/domain/destination.dart';
import '../../locations/domain/coordinates.dart';
import '../data/directions_service.dart';
import '../data/route_cache_repository.dart';
import '../domain/route_data.dart';

enum RouteStatus { initial, loading, loaded, fallback, failure }

class RouteCalculationState extends Equatable {
  const RouteCalculationState({
    this.status = RouteStatus.initial,
    this.route,
    this.message,
  });

  final RouteStatus status;
  final RouteData? route;
  final String? message;

  RouteCalculationState copyWith({
    RouteStatus? status,
    RouteData? route,
    String? message,
  }) {
    return RouteCalculationState(
      status: status ?? this.status,
      route: route ?? this.route,
      message: message,
    );
  }

  @override
  List<Object?> get props => [status, route, message];
}

sealed class RouteCalculationEvent extends Equatable {
  const RouteCalculationEvent();

  @override
  List<Object?> get props => [];
}

class RouteRequested extends RouteCalculationEvent {
  const RouteRequested({
    required this.destinations,
    required this.timeMinutes,
    this.charkhStableId,
  });

  final List<DestinationDraft> destinations;
  final int timeMinutes;
  final String? charkhStableId;

  @override
  List<Object?> get props => [destinations, timeMinutes, charkhStableId];
}

class RouteCalculationBloc
    extends Bloc<RouteCalculationEvent, RouteCalculationState> {
  RouteCalculationBloc({
    required this.routeCacheRepository,
    required this.directionsService,
  }) : super(const RouteCalculationState()) {
    on<RouteRequested>(_onRequested);
  }

  final RouteCacheRepository routeCacheRepository;
  final DirectionsService directionsService;

  Future<void> _onRequested(
    RouteRequested event,
    Emitter<RouteCalculationState> emit,
  ) async {
    emit(const RouteCalculationState(status: RouteStatus.loading));
    final coordinates = event.destinations
        .map((item) => item.coordinates)
        .whereType<Coordinates>()
        .toList(growable: false);

    if (event.charkhStableId != null) {
      final cached = await routeCacheRepository.getRouteCache(
        event.charkhStableId!,
      );
      if (cached != null && cached.points.isNotEmpty) {
        emit(RouteCalculationState(status: RouteStatus.loaded, route: cached));
      }
    }

    try {
      final route = await directionsService.calculate(coordinates);
      if (event.charkhStableId != null) {
        await routeCacheRepository.saveRouteCache(event.charkhStableId!, route);
      }
      emit(RouteCalculationState(status: RouteStatus.loaded, route: route));
    } catch (error) {
      final fallback = buildFallbackRoute(
        coordinates: coordinates,
        timeMinutes: event.timeMinutes,
      );
      emit(
        RouteCalculationState(
          status: RouteStatus.fallback,
          route: fallback,
          message: error.toString(),
        ),
      );
    }
  }
}
