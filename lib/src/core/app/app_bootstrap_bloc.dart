import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

import '../../features/charkhs/data/charkh_repository.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../features/routes/data/active_route_repository.dart';
import '../../features/routes/data/directions_service.dart';
import '../../features/routes/data/route_cache_repository.dart';
import '../di/app_dependencies.dart';
import '../storage/entities.dart';
import '../storage/isar_seed_service.dart';

sealed class AppBootstrapEvent extends Equatable {
  const AppBootstrapEvent();

  @override
  List<Object?> get props => [];
}

class AppBootstrapStarted extends AppBootstrapEvent {
  const AppBootstrapStarted();
}

enum AppBootstrapStatus { loading, ready, failure }

class AppBootstrapState extends Equatable {
  const AppBootstrapState({
    required this.status,
    this.dependencies,
    this.message,
  });

  const AppBootstrapState.loading()
    : status = AppBootstrapStatus.loading,
      dependencies = null,
      message = null;

  final AppBootstrapStatus status;
  final AppDependencies? dependencies;
  final String? message;

  @override
  List<Object?> get props => [status, dependencies, message];
}

class AppBootstrapBloc extends Bloc<AppBootstrapEvent, AppBootstrapState> {
  AppBootstrapBloc() : super(const AppBootstrapState.loading()) {
    on<AppBootstrapStarted>(_onStarted);
  }

  Future<void> _onStarted(
    AppBootstrapStarted event,
    Emitter<AppBootstrapState> emit,
  ) async {
    emit(const AppBootstrapState.loading());
    try {
      final directory = await getApplicationDocumentsDirectory();
      final isar = await Isar.open(
        [
          ProfileRecordSchema,
          CharkhRecordSchema,
          DestinationRecordSchema,
          RouteCacheRecordSchema,
          ActiveRouteRecordSchema,
        ],
        directory: directory.path,
        inspector: false,
      );
      await IsarSeedService(isar).seedIfEmpty();
      final dependencies = AppDependencies(
        profileRepository: ProfileRepository(isar),
        charkhRepository: CharkhRepository(isar),
        routeCacheRepository: RouteCacheRepository(isar),
        activeRouteRepository: ActiveRouteRepository(isar),
        directionsService: DirectionsService(),
      );
      emit(
        AppBootstrapState(
          status: AppBootstrapStatus.ready,
          dependencies: dependencies,
        ),
      );
    } catch (error) {
      emit(
        AppBootstrapState(
          status: AppBootstrapStatus.failure,
          message: error.toString(),
        ),
      );
    }
  }
}
