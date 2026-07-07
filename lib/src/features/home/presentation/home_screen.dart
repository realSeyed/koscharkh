import 'package:flutter/material.dart';

import '../../../core/theme/koscharkh_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: context.colors.surface,
      child: const SizedBox.expand(),
    );
  }
}
