import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../routing/app_router.dart';
import '../theme/koscharkh_theme.dart';
import 'app_bootstrap_bloc.dart';

class KoscharkhApp extends StatelessWidget {
  const KoscharkhApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBootstrapBloc, AppBootstrapState>(
      builder: (context, state) {
        final theme = buildKoscharkhDarkTheme();
        if (state.status == AppBootstrapStatus.ready &&
            state.dependencies != null) {
          final router = createRouter(state.dependencies!);
          return RepositoryProvider.value(
            value: state.dependencies!,
            child: MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'KosCharkh',
              theme: theme,
              routerConfig: router,
            ),
          );
        }

        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'KosCharkh',
          theme: theme,
          home: Scaffold(
            backgroundColor: theme.scaffoldBackgroundColor,
            body: Center(
              child: Text(
                state.status == AppBootstrapStatus.failure
                    ? state.message ?? 'Failed to start'
                    : 'KosCharkh',
                style: theme.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        );
      },
    );
  }
}
