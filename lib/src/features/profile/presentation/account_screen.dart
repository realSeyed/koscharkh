import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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

class _ProfileLine extends StatelessWidget {
  const _ProfileLine(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(text, style: Theme.of(context).textTheme.bodySmall);
  }
}

String _valueOrEmpty(String value) => value.trim().isEmpty ? 'empty' : value;
