import '../../features/charkhs/data/charkh_repository.dart';
import '../../features/destinations/data/destination_library_repository.dart';
import '../../features/locations/data/compass_heading_service.dart';
import '../../features/locations/data/current_location_service.dart';
import '../../features/locations/data/reverse_geocoding_service.dart';
import '../../features/profile/data/profile_repository.dart';
import '../../features/routes/data/active_route_repository.dart';
import '../../features/routes/data/charkh_history_repository.dart';
import '../../features/routes/data/directions_service.dart';
import '../../features/routes/data/route_cache_repository.dart';

class AppDependencies {
  const AppDependencies({
    required this.profileRepository,
    required this.charkhRepository,
    required this.destinationLibraryRepository,
    required this.routeCacheRepository,
    required this.activeRouteRepository,
    required this.charkhHistoryRepository,
    required this.directionsService,
    required this.reverseGeocodingService,
    required this.currentLocationService,
    required this.compassHeadingService,
  });

  final ProfileRepository profileRepository;
  final CharkhRepository charkhRepository;
  final DestinationLibraryRepository destinationLibraryRepository;
  final RouteCacheRepository routeCacheRepository;
  final ActiveRouteRepository activeRouteRepository;
  final CharkhHistoryRepository charkhHistoryRepository;
  final DirectionsService directionsService;
  final ReverseGeocodingService reverseGeocodingService;
  final CurrentLocationService currentLocationService;
  final CompassHeadingService compassHeadingService;
}
