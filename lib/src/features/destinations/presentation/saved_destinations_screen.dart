import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/application/load_status.dart';
import '../../../core/routing/route_args.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
import '../application/destination_library_cubit.dart';
import '../domain/destination.dart';

class SavedDestinationsScreen extends StatelessWidget {
  const SavedDestinationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: BlocBuilder<DestinationLibraryCubit, DestinationLibraryState>(
        builder: (context, state) {
          final cubit = context.read<DestinationLibraryCubit>();
          return ListView(
            padding: EdgeInsets.zero,
            children: [
              const HeaderWithBack(title: 'Saved Destinations'),
              if (state.status == LoadStatus.loading)
                Center(
                  child: CircularProgressIndicator(
                    color: context.colors.primary,
                  ),
                )
              else ...[
                for (var i = 0; i < state.destinations.length; i++) ...[
                  DestinationCard(
                    index: i + 1,
                    destination: state.destinations[i],
                    onEdit: () async {
                      final result = await context.push<DestinationDraft>(
                        '/destination/${state.destinations[i].stableId}/edit',
                        extra: DestinationFormArgs(
                          draft: state.destinations[i],
                        ),
                      );
                      if (result != null && context.mounted) {
                        await cubit.saveDestination(result);
                      }
                    },
                    onDelete: () async {
                      final confirmed = await confirmDestructiveAction(
                        context,
                        title: 'Delete Destination',
                        message:
                            'Remove ${state.destinations[i].name} from saved destinations?',
                      );
                      if (confirmed && context.mounted) {
                        await cubit.deleteDestination(
                          state.destinations[i].stableId,
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                ],
                if (state.destinations.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Text(
                      'No saved destinations yet.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurfaceMuted,
                      ),
                    ),
                  ),
                KosButton(
                  text: '+ Add Destination',
                  onPressed: () async {
                    final result = await context.push<DestinationDraft>(
                      '/destination/new',
                    );
                    if (result != null && context.mounted) {
                      await cubit.saveDestination(result);
                    }
                  },
                ),
              ],
              ErrorCaption(state.message),
              const SizedBox(height: 28),
            ],
          );
        },
      ),
    );
  }
}
