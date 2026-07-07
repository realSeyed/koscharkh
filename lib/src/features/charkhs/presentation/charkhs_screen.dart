import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/components.dart';
import '../application/charkh_list_cubit.dart';

class CharkhsScreen extends StatelessWidget {
  const CharkhsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
        child: BlocBuilder<CharkhListCubit, CharkhListState>(
          builder: (context, state) {
            return Stack(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Charkhs',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 22),
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.only(bottom: 96),
                        itemCount: state.charkhs.length,
                        separatorBuilder: (_, index) =>
                            const SizedBox(height: 10),
                        itemBuilder: (context, index) {
                          final charkh = state.charkhs[index];
                          return CharkhCard(
                            charkh: charkh,
                            onStart: () =>
                                context.push('/charkhs/${charkh.stableId}/map'),
                            onEdit: () async {
                              await context.push(
                                '/charkhs/${charkh.stableId}/edit',
                              );
                              if (context.mounted) {
                                context.read<CharkhListCubit>().load();
                              }
                            },
                            onDelete: () async {
                              final confirmed = await confirmDestructiveAction(
                                context,
                                title: 'Delete Charkh',
                                message: 'Remove ${charkh.name}?',
                              );
                              if (confirmed && context.mounted) {
                                context.read<CharkhListCubit>().delete(
                                  charkh.stableId,
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
                Positioned(
                  right: 0,
                  bottom: 22,
                  child: KosButton(
                    text: '+ Add Charkh',
                    width: 140,
                    height: 56,
                    onPressed: () async {
                      await context.push('/charkhs/new');
                      if (context.mounted) {
                        context.read<CharkhListCubit>().load();
                      }
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
