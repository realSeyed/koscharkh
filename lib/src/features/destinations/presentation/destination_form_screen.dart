import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/app_feedback.dart';
import '../../../core/widgets/components.dart';
import '../../locations/domain/location_selection.dart';
import '../application/destination_form_cubit.dart';

class DestinationFormScreen extends StatelessWidget {
  const DestinationFormScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return BlocListener<DestinationFormCubit, DestinationFormState>(
      listenWhen: (previous, current) => current.submittedDraft != null,
      listener: (context, state) => context.pop(state.submittedDraft),
      child: AppScreen(
        child: BlocBuilder<DestinationFormCubit, DestinationFormState>(
          builder: (context, state) {
            final cubit = context.read<DestinationFormCubit>();
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                HeaderWithBack(title: title),
                const FieldLabel('Name'),
                KosTextInput(
                  value: state.name,
                  placeholder: 'eg. First Destination Name',
                  onChanged: cubit.nameChanged,
                ),
                const SizedBox(height: 16),
                const FieldLabel('Description'),
                Row(
                  children: [
                    Expanded(
                      child: KosTextInput(
                        value: state.description,
                        placeholder: 'eg. First Destination Desc...',
                        onChanged: cubit.descriptionChanged,
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
                KosButton(
                  text: state.location == null
                      ? 'Select location on map'
                      : 'Selected location on map',
                  icon: KosAssets.map,
                  onPressed: () async {
                    final result = await context.push<LocationSelection>(
                      '/location/select',
                      extra: state.location,
                    );
                    if (result != null && context.mounted) {
                      cubit.locationChanged(result);
                    }
                  },
                ),
                if (state.canSaveToLibrary) ...[
                  const SizedBox(height: 12),
                  _SaveToLibraryToggle(
                    value: state.saveToLibrary,
                    onChanged: cubit.saveToLibraryChanged,
                  ),
                ],
                ErrorCaption(state.validationMessage),
                const SizedBox(height: 14),
                KosButton(text: 'Submit', onPressed: cubit.submit),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _SaveToLibraryToggle extends StatelessWidget {
  const _SaveToLibraryToggle({required this.value, required this.onChanged});

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceMuted,
      child: InkWell(
        onTap: () => onChanged(!value),
        child: SizedBox(
          height: 51,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                SizedBox(
                  width: 24,
                  height: 24,
                  child: Checkbox(
                    value: value,
                    onChanged: (next) => onChanged(next ?? false),
                    activeColor: context.colors.primary,
                    checkColor: context.colors.onPrimary,
                    side: BorderSide(color: context.colors.onSurface),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Save to Saved Destinations',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
