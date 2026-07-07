import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/di/app_dependencies.dart';
import '../../../../core/map/kos_map.dart';
import '../../../../core/routing/route_args.dart';
import '../../../../core/theme/koscharkh_theme.dart';
import '../../../../core/widgets/components.dart';
import '../../../routes/application/route_calculation_bloc.dart';

class RoutePreviewThumbnail extends StatelessWidget {
  const RoutePreviewThumbnail({super.key, required this.args});

  final RoutePreviewArgs args;

  @override
  Widget build(BuildContext context) {
    if (!_hasRoute(args)) {
      return const _MatteRoutePreview();
    }

    final dependencies = context.read<AppDependencies>();
    return BlocProvider(
      key: ValueKey(_routeSignature(args)),
      create: (context) =>
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
      child: GestureDetector(
        onTap: () => context.push('/route-preview', extra: args),
        child: SizedBox(
          height: 190,
          child: Stack(
            fit: StackFit.expand,
            children: [
              BlocBuilder<RouteCalculationBloc, RouteCalculationState>(
                builder: (context, state) {
                  return KosMap(
                    points: state.route?.points ?? const [],
                    destinations: args.destinations,
                    interactive: false,
                  );
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: IconButton(
                  tooltip: 'Open preview',
                  onPressed: () => context.push('/route-preview', extra: args),
                  icon: KosSvgIcon(
                    KosAssets.cropFree,
                    color: context.colors.onSurface,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

bool _hasRoute(RoutePreviewArgs args) {
  return args.destinations.where((item) => item.coordinates != null).length >=
      2;
}

String _routeSignature(RoutePreviewArgs args) {
  final coordinates = args.destinations
      .map((item) => item.coordinates)
      .where((item) => item != null)
      .map((item) => '${item!.latitude},${item.longitude}')
      .join('|');
  return '${args.charkhStableId ?? 'draft'}:${args.timeMinutes}:$coordinates';
}

class _MatteRoutePreview extends StatelessWidget {
  const _MatteRoutePreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      color: context.colors.surfaceMuted,
      child: Center(
        child: KosSvgIcon(
          KosAssets.map,
          size: 32,
          color: context.colors.onSurfaceMuted,
        ),
      ),
    );
  }
}
