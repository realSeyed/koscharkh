import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/map/kos_map.dart';
import '../../../core/routing/route_args.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
import '../application/route_calculation_bloc.dart';

class RoutePreviewScreen extends StatelessWidget {
  const RoutePreviewScreen({super.key, required this.args});

  final RoutePreviewArgs args;

  @override
  Widget build(BuildContext context) {
    final hasRoute =
        args.destinations.where((item) => item.coordinates != null).length >= 2;
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: Stack(
        children: [
          if (hasRoute)
            BlocBuilder<RouteCalculationBloc, RouteCalculationState>(
              builder: (context, state) {
                return KosMap(
                  points: state.route?.points ?? const [],
                  destinations: args.destinations,
                  interactive: true,
                );
              },
            )
          else
            ColoredBox(color: context.colors.surfaceMuted),
          Positioned(
            right: 20,
            top: MediaQuery.paddingOf(context).top + 12,
            child: IconButton(
              tooltip: 'Close preview',
              onPressed: () => context.pop(),
              icon: KosSvgIcon(
                KosAssets.fullscreenExit,
                color: context.colors.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
