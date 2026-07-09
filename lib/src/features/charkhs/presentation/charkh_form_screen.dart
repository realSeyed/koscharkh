import 'package:equatable/equatable.dart';
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
          buildWhen: (previous, current) {
            return previous.status != current.status &&
                (previous.status == LoadStatus.loading ||
                    current.status == LoadStatus.loading ||
                    current.status == LoadStatus.failure);
          },
          builder: (context, state) {
            if (state.status == LoadStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: EdgeInsets.zero,
              children: [
                HeaderWithBack(title: title),
                const FieldLabel('Name'),
                const _NameField(),
                const SizedBox(height: 16),
                const FieldLabel('Time'),
                const _TimeField(),
                const SizedBox(height: 18),
                const FieldLabel('Route Preview'),
                const _RoutePreviewSection(),
                const SizedBox(height: 16),
                const FieldLabel('Destinations'),
                const _DestinationsSection(),
                const _FormFeedback(),
                const SizedBox(height: 14),
                KosButton(
                  text: 'Submit',
                  onPressed: context.read<CharkhFormCubit>().save,
                ),
                const SizedBox(height: 28),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _NameField extends StatelessWidget {
  const _NameField();

  @override
  Widget build(BuildContext context) {
    final name = context.select((CharkhFormCubit cubit) => cubit.state.name);
    return KosTextInput(
      value: name,
      placeholder: 'eg. First Charkh',
      onChanged: context.read<CharkhFormCubit>().nameChanged,
    );
  }
}

class _TimeField extends StatelessWidget {
  const _TimeField();

  @override
  Widget build(BuildContext context) {
    final time = context.select((CharkhFormCubit cubit) => cubit.state.time);
    return Row(
      children: [
        Expanded(
          child: KosTextInput(
            value: time,
            placeholder: '30 (min)',
            keyboardType: TextInputType.number,
            onChanged: context.read<CharkhFormCubit>().timeChanged,
          ),
        ),
        const SizedBox(width: 10),
        IconSquareButton(
          asset: KosAssets.electricBolt,
          onPressed: () => showSuggestionComingSoon(context),
        ),
      ],
    );
  }
}

class _RoutePreviewSection extends StatelessWidget {
  const _RoutePreviewSection();

  @override
  Widget build(BuildContext context) {
    return BlocSelector<CharkhFormCubit, CharkhFormState, _RoutePreviewInput>(
      selector: (state) {
        return _RoutePreviewInput(
          charkhStableId: state.stableId,
          destinations: state.destinations,
        );
      },
      builder: (context, input) {
        return RoutePreviewThumbnail(
          args: RoutePreviewArgs(
            title: 'Route Preview',
            destinations: input.destinations,
            timeMinutes: 30,
            charkhStableId: input.charkhStableId,
          ),
        );
      },
    );
  }
}

class _DestinationsSection extends StatelessWidget {
  const _DestinationsSection();

  @override
  Widget build(BuildContext context) {
    final destinations = context.select(
      (CharkhFormCubit cubit) => cubit.state.destinations,
    );
    final cubit = context.read<CharkhFormCubit>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < destinations.length; i++) ...[
          DestinationCard(
            index: i + 1,
            destination: destinations[i],
            onEdit: () async {
              final result = await context.push<DestinationDraft>(
                '/destination/${destinations[i].stableId}/edit',
                extra: DestinationFormArgs(
                  draft: destinations[i],
                  canSaveToLibrary: true,
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
                message: 'Remove ${destinations[i].name}?',
              );
              if (confirmed) {
                cubit.removeDestination(destinations[i].stableId);
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
              extra: const DestinationFormArgs(canSaveToLibrary: true),
            );
            if (result != null && context.mounted) {
              cubit.addDestination(result);
            }
          },
        ),
        const SizedBox(height: 8),
        KosButton(
          text: '+ Use Saved Destination',
          variant: KosButtonVariant.secondary,
          onPressed: () async {
            final result = await context.push<DestinationDraft>(
              '/destinations/select',
            );
            if (result != null && context.mounted) {
              cubit.addSavedDestination(result);
            }
          },
        ),
      ],
    );
  }
}

class _FormFeedback extends StatelessWidget {
  const _FormFeedback();

  @override
  Widget build(BuildContext context) {
    final feedback = context.select((CharkhFormCubit cubit) {
      return _FormFeedbackInput(
        validationMessage: cubit.state.validationMessage,
        hasDestinations: cubit.state.destinations.isNotEmpty,
      );
    });
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ErrorCaption(feedback.validationMessage),
        if (!feedback.hasDestinations)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Add destinations when you are ready.',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceMuted,
              ),
            ),
          ),
      ],
    );
  }
}

class _RoutePreviewInput extends Equatable {
  const _RoutePreviewInput({
    required this.charkhStableId,
    required this.destinations,
  });

  final String? charkhStableId;
  final List<DestinationDraft> destinations;

  @override
  List<Object?> get props => [charkhStableId, destinations];
}

class _FormFeedbackInput extends Equatable {
  const _FormFeedbackInput({
    required this.validationMessage,
    required this.hasDestinations,
  });

  final String? validationMessage;
  final bool hasDestinations;

  @override
  List<Object?> get props => [validationMessage, hasDestinations];
}
