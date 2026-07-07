import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/map/kos_map.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/utils/time_format.dart';
import '../../charkhs/data/charkh_repository.dart';
import '../../charkhs/domain/charkh.dart';
import '../../destinations/domain/destination.dart';
import '../application/active_route_bloc.dart';
import '../application/route_calculation_bloc.dart';
import '../data/active_route_repository.dart';
import '../data/directions_service.dart';
import '../data/route_cache_repository.dart';

class ActiveMapScreen extends StatelessWidget {
  const ActiveMapScreen({
    super.key,
    required this.charkhStableId,
    required this.charkhRepository,
    required this.routeCacheRepository,
    required this.activeRouteRepository,
    required this.directionsService,
  });

  final String charkhStableId;
  final CharkhRepository charkhRepository;
  final RouteCacheRepository routeCacheRepository;
  final ActiveRouteRepository activeRouteRepository;
  final DirectionsService directionsService;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Charkh?>(
      future: charkhRepository.getCharkh(charkhStableId),
      builder: (context, snapshot) {
        final charkh = snapshot.data;
        if (charkh == null) {
          return Scaffold(
            backgroundColor: context.colors.surface,
            body: Center(
              child: Text(
                snapshot.connectionState == ConnectionState.done
                    ? 'Charkh not found'
                    : 'Loading',
              ),
            ),
          );
        }
        final destinations = charkh.destinations
            .map(DestinationDraft.fromDestination)
            .toList();
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (_) =>
                  RouteCalculationBloc(
                    routeCacheRepository: routeCacheRepository,
                    directionsService: directionsService,
                  )..add(
                    RouteRequested(
                      destinations: destinations,
                      timeMinutes: charkh.timeMinutes,
                      charkhStableId: charkh.stableId,
                    ),
                  ),
            ),
            BlocProvider(create: (_) => ActiveRouteBloc(activeRouteRepository)),
          ],
          child: _ActiveMapView(charkh: charkh, destinations: destinations),
        );
      },
    );
  }
}

class _ActiveMapView extends StatelessWidget {
  const _ActiveMapView({required this.charkh, required this.destinations});

  final Charkh charkh;
  final List<DestinationDraft> destinations;

  @override
  Widget build(BuildContext context) {
    return BlocListener<RouteCalculationBloc, RouteCalculationState>(
      listenWhen: (previous, current) =>
          previous.route != current.route && current.route != null,
      listener: (context, state) {
        context.read<ActiveRouteBloc>().add(
          ActiveRouteStarted(
            charkh: charkh,
            routeDurationSeconds: state.route!.durationSeconds,
          ),
        );
      },
      child: Scaffold(
        backgroundColor: context.colors.surface,
        body: Stack(
          children: [
            BlocBuilder<RouteCalculationBloc, RouteCalculationState>(
              builder: (context, routeState) {
                return KosMap(
                  points: routeState.route?.points ?? const [],
                  destinations: destinations,
                  showUserMarker: true,
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: SafeArea(
                top: false,
                child: Container(
                  color: context.colors.surface,
                  padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                  child: BlocBuilder<ActiveRouteBloc, ActiveRouteState>(
                    builder: (context, state) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 112,
                              height: 3,
                              color: context.colors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 24),
                          Text(
                            charkh.name,
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                          const SizedBox(height: 12),
                          _StatusRow(
                            label: 'Elapsed Time:',
                            value: formatClock(state.elapsedSeconds),
                          ),
                          _StatusRow(
                            label: 'ETA:',
                            value: formatClock(state.etaSeconds),
                          ),
                          _StatusRow(
                            label: 'Next:',
                            value: state.nextDestination,
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  const _StatusRow({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.bodySmall),
          ),
          Expanded(
            child: Text(
              value,
              style: Theme.of(context).textTheme.bodySmall,
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
