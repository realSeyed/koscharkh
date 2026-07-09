import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/application/load_status.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
import '../application/destination_library_cubit.dart';

class SavedDestinationPickerScreen extends StatelessWidget {
  const SavedDestinationPickerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppScreen(
      child: BlocBuilder<DestinationLibraryCubit, DestinationLibraryState>(
        builder: (context, state) {
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
              else if (state.destinations.isEmpty)
                Text(
                  'No saved destinations yet.',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceMuted,
                  ),
                )
              else
                for (var i = 0; i < state.destinations.length; i++) ...[
                  _SavedDestinationRow(
                    index: i + 1,
                    name: state.destinations[i].name,
                    description: state.destinations[i].description,
                    onTap: () => context.pop(state.destinations[i]),
                  ),
                  const SizedBox(height: 8),
                ],
              ErrorCaption(state.message),
            ],
          );
        },
      ),
    );
  }
}

class _SavedDestinationRow extends StatelessWidget {
  const _SavedDestinationRow({
    required this.index,
    required this.name,
    required this.description,
    required this.onTap,
  });

  final int index;
  final String name;
  final String description;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceMuted,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$index. $name',
                style: Theme.of(context).textTheme.bodySmall,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (description.trim().isNotEmpty) ...[
                const SizedBox(height: 4),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceMuted,
                    fontSize: 11,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
