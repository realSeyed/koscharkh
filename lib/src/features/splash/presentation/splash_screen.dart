import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/koscharkh_theme.dart';
import '../../../core/widgets/components.dart';
import '../application/splash_bloc.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashBloc, SplashState>(
      listenWhen: (previous, current) => !previous.ready && current.ready,
      listener: (context, state) => context.go('/home'),
      child: Scaffold(
        backgroundColor: context.colors.surface,
        body: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              KosSvgIcon(KosAssets.barefoot, color: context.colors.onSurface),
              const SizedBox(width: 10),
              Text(
                'KosCharkh',
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
