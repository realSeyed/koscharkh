import 'package:flutter/material.dart';

import '../theme/koscharkh_theme.dart';

void showSuggestionComingSoon(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: context.colors.surfaceMuted,
      content: const Text('Suggestion coming soon'),
      duration: const Duration(milliseconds: 900),
    ),
  );
}
