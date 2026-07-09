import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/utils/time_format.dart';
import '../../../core/widgets/components.dart';
import '../../routes/domain/charkh_history.dart';
import '../application/profile_cubit.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 36, 24, 0),
        child: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            final profile = state.profile;
            return Stack(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: IconButton(
                    tooltip: 'Edit profile',
                    onPressed: () async {
                      await context.push('/account/edit');
                      if (context.mounted) {
                        context.read<ProfileCubit>().load();
                      }
                    },
                    icon: KosSvgIcon(
                      KosAssets.edit,
                      color: context.colors.onSurface,
                    ),
                  ),
                ),
                ListView(
                  padding: const EdgeInsets.only(bottom: 32),
                  children: [
                    const SizedBox(height: 10),
                    Center(
                      child: KosSvgIcon(
                        KosAssets.accountFilled,
                        size: 72,
                        color: context.colors.onSurface,
                      ),
                    ),
                    const SizedBox(height: 42),
                    _ProfileLine(
                      'First Name: ${_valueOrEmpty(profile.firstName)}',
                    ),
                    const SizedBox(height: 8),
                    _ProfileLine(
                      'Last Name: ${_valueOrEmpty(profile.lastName)}',
                    ),
                    const SizedBox(height: 8),
                    _ProfileLine('Age: ${_valueOrEmpty(profile.age)}'),
                    const SizedBox(height: 32),
                    const _AccountTabs(),
                    const SizedBox(height: 32),
                    _HistorySection(history: state.history),
                    ErrorCaption(state.message),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _AccountTabs extends StatelessWidget {
  const _AccountTabs();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel('Account'),
        _AccountTab(
          text: 'Saved Destinations',
          onTap: () => context.push('/account/destinations'),
        ),
      ],
    );
  }
}

class _AccountTab extends StatelessWidget {
  const _AccountTab({required this.text, required this.onTap});

  final String text;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: context.colors.surfaceMuted,
      child: InkWell(
        onTap: onTap,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  '>',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceMuted,
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

class _HistorySection extends StatelessWidget {
  const _HistorySection({required this.history});

  final List<CharkhHistory> history;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const FieldLabel('History'),
        if (history.isEmpty)
          Text(
            'No completed charkhs yet.',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: context.colors.onSurfaceMuted,
            ),
          )
        else
          for (final item in history.take(8)) ...[
            _HistoryCard(item: item),
            const SizedBox(height: 8),
          ],
      ],
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({required this.item});

  final CharkhHistory item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: context.colors.surfaceMuted,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileLine('Charkh: ${item.charkhName}'),
          const SizedBox(height: 6),
          _ProfileLine('User: ${_valueOrEmpty(item.userName)}'),
          const SizedBox(height: 6),
          _ProfileLine('Started: ${_formatDateTime(item.startedAt)}'),
          const SizedBox(height: 6),
          _ProfileLine('Duration: ${formatClock(item.elapsedSeconds)}'),
          if (item.finalDestinationName != null) ...[
            const SizedBox(height: 6),
            _ProfileLine('Final: ${item.finalDestinationName}'),
          ],
        ],
      ),
    );
  }
}

class _ProfileLine extends StatelessWidget {
  const _ProfileLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}

String _valueOrEmpty(String value) => value.trim().isEmpty ? 'empty' : value;

String _formatDateTime(DateTime value) {
  final local = value.toLocal();
  return '${local.year}-${_two(local.month)}-${_two(local.day)} '
      '${_two(local.hour)}:${_two(local.minute)}';
}

String _two(int value) => value.toString().padLeft(2, '0');
