import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/application/load_status.dart';
import '../../../core/routing/route_args.dart';
import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/app_feedback.dart';
import '../../../core/widgets/components.dart';
import '../../destinations/domain/destination.dart';
import '../application/charkh_form_cubit.dart';
import 'widgets/route_preview_thumbnail.dart';

class CharkhFormScreen extends StatelessWidget {
  const CharkhFormScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharkhFormCubit, CharkhFormState>(
      listenWhen: (previous, current) => current.status == LoadStatus.saved,
      listener: (context, state) => context.pop(),
      child: AppScreen(
        child: BlocBuilder<CharkhFormCubit, CharkhFormState>(
          builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            final cubit = context.read<CharkhFormCubit>();
            final routeArgs = RoutePreviewArgs(
              title: state.name.trim().isEmpty
                  ? 'First Charkh'
                  : state.name.trim(),
              destinations: state.destinations,
              timeMinutes: state.parsedMinutes == 0 ? 30 : state.parsedMinutes,
              charkhStableId: state.stableId,
            );
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                HeaderWithBack(title: title),
                const FieldLabel('Name'),
                KosTextInput(
                  value: state.name,
                  placeholder: 'eg. First Charkh',
                  onChanged: cubit.nameChanged,
                ),
                const SizedBox(height: 16),
                const FieldLabel('Time'),
                Row(
                  children: [
                    Expanded(
                      child: KosTextInput(
                        value: state.time,
                        placeholder: '30 (min)',
                        keyboardType: TextInputType.number,
                        onChanged: cubit.timeChanged,
                      ),
                    ),
                    const SizedBox(width: 10),
                    IconSquareButton(
                      asset: KosAssets.electricBolt,
                      onPressed: () => showSuggestionComingSoon(context),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                const FieldLabel('Route Preview'),
                RoutePreviewThumbnail(args: routeArgs),
                const SizedBox(height: 16),
                const FieldLabel('Destinations'),
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
                        cubit.updateDestination(result);
                      }
                    },
                    onDelete: () async {
                      final confirmed = await confirmDestructiveAction(
                        context,
                        title: 'Delete Destination',
                        message: 'Remove ${state.destinations[i].name}?',
                      );
                      if (confirmed) {
                        cubit.removeDestination(state.destinations[i].stableId);
                      }
                    },
                  ),
                  const SizedBox(height: 8),
                ],
                KosButton(
                  text: '+ Add Destination',
                  onPressed: () async {
                    final result = await context.push<DestinationDraft>(
                      '/destination/new',
                    );
                    if (result != null && context.mounted) {
                      cubit.addDestination(result);
                    }
                  },
                ),
                ErrorCaption(state.validationMessage),
                if (state.destinations.isEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      'Add destinations when you are ready.',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: context.colors.onSurfaceMuted,
                      ),
                    ),
                  ),
                const SizedBox(height: 14),
                KosButton(text: 'Submit', onPressed: cubit.save),
                const SizedBox(height: 28),
              ],
            );
          },
        ),
      ),
    );
  }
}
