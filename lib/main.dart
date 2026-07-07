import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'src/core/app/app_bootstrap_bloc.dart';
import 'src/core/app/koscharkh_app.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    BlocProvider(
      create: (_) => AppBootstrapBloc()..add(const AppBootstrapStarted()),
      child: const KoscharkhApp(),
    ),
  );
}
