import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/map/kos_map.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
import '../application/location_picker_cubit.dart';

class SelectLocationScreen extends StatelessWidget {
  const SelectLocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.surface,
      body: BlocBuilder<LocationPickerCubit, LocationPickerState>(
        builder: (context, state) {
          return Stack(
            children: [
              KosMap(
                points: const [],
                selectedLocation: state.selection,
                showUserMarker: true,
                onTap: context.read<LocationPickerCubit>().select,
                onRecenter: context.read<LocationPickerCubit>().recenter,
              ),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: SafeArea(
                  top: false,
                  child: Container(
                    color: context.colors.surface,
                    padding: const EdgeInsets.fromLTRB(24, 16, 24, 18),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          state.selection.address ?? 'Selected location',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Coordinates: ${state.selection.coordinates.latitude.toStringAsFixed(12)}, ${state.selection.coordinates.longitude.toStringAsFixed(8)}',
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 12),
                        KosButton(
                          text: 'Select',
                          onPressed: () => context.pop(state.selection),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
