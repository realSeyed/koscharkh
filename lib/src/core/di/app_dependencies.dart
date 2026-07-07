import '../../features/charkhs/data/charkh_repository.dart';
import '../../features/locations/data/current_location_service.dart';
import '../../features/locations/data/reverse_geocoding_service.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../features/routes/data/active_route_repository.dart';
import '../../features/routes/data/directions_service.dart';
import '../../features/routes/data/route_cache_repository.dart';

class AppDependencies {
  const AppDependencies({
    required this.profileRepository,
    required this.charkhRepository,
    required this.routeCacheRepository,
    required this.activeRouteRepository,
    required this.directionsService,
    required this.reverseGeocodingService,
    required this.currentLocationService,
  });

  final ProfileRepository profileRepository;
  final CharkhRepository charkhRepository;
  final RouteCacheRepository routeCacheRepository;
  final ActiveRouteRepository activeRouteRepository;
  final DirectionsService directionsService;
  final ReverseGeocodingService reverseGeocodingService;
  final CurrentLocationService currentLocationService;
}
