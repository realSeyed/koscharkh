import 'dart:math';

String formatClock(int seconds) {
  final normalized = max(0, seconds);
  final minutes = normalized ~/ 60;
  final remainingSeconds = normalized % 60;
  return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
}
