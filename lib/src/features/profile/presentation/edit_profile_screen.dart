import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/application/load_status.dart';
import '../../../core/widgets/components.dart';
import '../application/edit_profile_cubit.dart';
import '../application/profile_cubit.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, ProfileState>(
      listenWhen: (previous, current) => current.status == LoadStatus.saved,
      listener: (context, state) => context.pop(),
      child: AppScreen(
        child: BlocBuilder<EditProfileCubit, ProfileState>(
          builder: (context, state) {
            final profile = state.profile;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const HeaderWithBack(title: 'Edit Profile'),
                const FieldLabel('Firstname'),
                KosTextInput(
                  value: profile.firstName,
                  placeholder: 'eg. realseyed',
                  onChanged: context.read<EditProfileCubit>().firstNameChanged,
                ),
                const SizedBox(height: 16),
                const FieldLabel('Lastname'),
                KosTextInput(
                  value: profile.lastName,
                  placeholder: 'eg. First Destination Name',
                  onChanged: context.read<EditProfileCubit>().lastNameChanged,
                ),
                const SizedBox(height: 16),
                const FieldLabel('Age'),
                KosTextInput(
                  value: profile.age,
                  placeholder: 'eg. First Destination Name',
                  keyboardType: TextInputType.number,
                  onChanged: context.read<EditProfileCubit>().ageChanged,
                ),
                ErrorCaption(state.message),
                const SizedBox(height: 22),
                KosButton(
                  text: 'Submit',
                  onPressed: context.read<EditProfileCubit>().save,
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
