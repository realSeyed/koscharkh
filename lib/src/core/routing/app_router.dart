import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/charkhs/application/charkh_form_cubit.dart';
import '../../features/charkhs/application/charkh_list_cubit.dart';
import '../../features/charkhs/presentation/charkh_form_screen.dart';
import '../../features/charkhs/presentation/charkhs_screen.dart';
import '../../features/destinations/application/destination_form_cubit.dart';
import '../../features/destinations/presentation/destination_form_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/locations/application/location_picker_cubit.dart';
import '../../features/locations/domain/location_selection.dart';
import '../../features/locations/presentation/select_location_screen.dart';
import '../../features/profile/application/edit_profile_cubit.dart';
import '../../features/profile/application/profile_cubit.dart';
import '../../features/profile/presentation/account_screen.dart';
import '../../features/profile/presentation/edit_profile_screen.dart';
import '../../features/routes/application/route_calculation_bloc.dart';
import '../../features/routes/presentation/active_map_screen.dart';
import '../../features/routes/presentation/route_preview_screen.dart';
import '../../features/splash/application/splash_bloc.dart';
import '../../features/splash/presentation/splash_screen.dart';
import '../di/app_dependencies.dart';
import '../widgets/components.dart';
import 'route_args.dart';

GoRouter createRouter(AppDependencies dependencies) {
  return GoRouter(
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/splash',
        builder: (context, state) => BlocProvider(
          create: (_) => SplashBloc()..add(const SplashStarted()),
          child: const SplashScreen(),
        ),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/charkhs',
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      CharkhListCubit(dependencies.charkhRepository)..load(),
                  child: const CharkhsScreen(),
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/account',
                builder: (context, state) => BlocProvider(
                  create: (_) =>
                      ProfileCubit(dependencies.profileRepository)..load(),
                  child: const AccountScreen(),
                ),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        path: '/charkhs/new',
        builder: (context, state) => BlocProvider(
          create: (_) =>
              CharkhFormCubit(repository: dependencies.charkhRepository),
          child: const CharkhFormScreen(title: 'Create Charkh'),
        ),
      ),
      GoRoute(
        path: '/charkhs/:charkhStableId/edit',
        builder: (context, state) => BlocProvider(
          create: (_) => CharkhFormCubit(
            repository: dependencies.charkhRepository,
            editStableId: state.pathParameters['charkhStableId'],
          ),
          child: const CharkhFormScreen(title: 'Edit Charkh'),
        ),
      ),
      GoRoute(
        path: '/destination/new',
        builder: (context, state) {
          final args = state.extra is DestinationFormArgs
              ? state.extra! as DestinationFormArgs
              : const DestinationFormArgs();
          return BlocProvider(
            create: (_) => DestinationFormCubit(args.draft),
            child: const DestinationFormScreen(title: 'Create Destination'),
          );
        },
      ),
      GoRoute(
        path: '/destination/:destinationStableId/edit',
        builder: (context, state) {
          final args = state.extra is DestinationFormArgs
              ? state.extra! as DestinationFormArgs
              : const DestinationFormArgs();
          return BlocProvider(
            create: (_) => DestinationFormCubit(args.draft),
            child: const DestinationFormScreen(title: 'Edit Destination'),
          );
        },
      ),
      GoRoute(
        path: '/location/select',
        builder: (context, state) {
          final initial = state.extra is LocationSelection
              ? state.extra! as LocationSelection
              : null;
          return BlocProvider(
            create: (_) => LocationPickerCubit(
              initial: initial,
              reverseGeocodingService: dependencies.reverseGeocodingService,
              currentLocationService: dependencies.currentLocationService,
            ),
            child: const SelectLocationScreen(),
          );
        },
      ),
      GoRoute(
        path: '/route-preview',
        builder: (context, state) {
          final args = state.extra! as RoutePreviewArgs;
          return BlocProvider(
            create: (_) =>
                RouteCalculationBloc(
                  routeCacheRepository: dependencies.routeCacheRepository,
                  directionsService: dependencies.directionsService,
                )..add(
                  RouteRequested(
                    destinations: args.destinations,
                    timeMinutes: args.timeMinutes,
                    charkhStableId: args.charkhStableId,
                  ),
                ),
            child: RoutePreviewScreen(args: args),
          );
        },
      ),
      GoRoute(
        path: '/charkhs/:charkhStableId/map',
        builder: (context, state) => ActiveMapScreen(
          charkhStableId: state.pathParameters['charkhStableId']!,
          charkhRepository: dependencies.charkhRepository,
          activeRouteRepository: dependencies.activeRouteRepository,
          directionsService: dependencies.directionsService,
          currentLocationService: dependencies.currentLocationService,
        ),
      ),
      GoRoute(
        path: '/account/edit',
        builder: (context, state) => BlocProvider(
          create: (_) => EditProfileCubit(dependencies.profileRepository),
          child: const EditProfileScreen(),
        ),
      ),
    ],
  );
}

class MainShell extends StatelessWidget {
  const MainShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: navigationShell,
      bottomNavigationBar: KosBottomNav(
        currentIndex: navigationShell.currentIndex,
        onTap: (index) {
          navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}
