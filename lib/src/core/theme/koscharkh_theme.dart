import 'package:flutter/material.dart';

@immutable
class KoscharkhColors extends ThemeExtension<KoscharkhColors> {
  const KoscharkhColors({
    required this.primary,
    required this.onPrimary,
    required this.surface,
    required this.surfaceMuted,
    required this.onSurface,
    required this.onSurfaceMuted,
    required this.border,
    required this.error,
    required this.onError,
    required this.success,
    required this.warning,
    required this.disabled,
    required this.onDisabled,
    required this.scrim,
    required this.green300,
    required this.green400,
    required this.green500,
    required this.green900,
    required this.neutral100,
    required this.neutral400,
    required this.neutral700,
    required this.neutral900,
    required this.blackSurface,
    required this.red300,
    required this.red500,
    required this.red950,
    required this.amber300,
  });

  final Color primary;
  final Color onPrimary;
  final Color surface;
  final Color surfaceMuted;
  final Color onSurface;
  final Color onSurfaceMuted;
  final Color border;
  final Color error;
  final Color onError;
  final Color success;
  final Color warning;
  final Color disabled;
  final Color onDisabled;
  final Color scrim;
  final Color green300;
  final Color green400;
  final Color green500;
  final Color green900;
  final Color neutral100;
  final Color neutral400;
  final Color neutral700;
  final Color neutral900;
  final Color blackSurface;
  final Color red300;
  final Color red500;
  final Color red950;
  final Color amber300;

  @override
  KoscharkhColors copyWith({
    Color? primary,
    Color? onPrimary,
    Color? surface,
    Color? surfaceMuted,
    Color? onSurface,
    Color? onSurfaceMuted,
    Color? border,
    Color? error,
    Color? onError,
    Color? success,
    Color? warning,
    Color? disabled,
    Color? onDisabled,
    Color? scrim,
    Color? green300,
    Color? green400,
    Color? green500,
    Color? green900,
    Color? neutral100,
    Color? neutral400,
    Color? neutral700,
    Color? neutral900,
    Color? blackSurface,
    Color? red300,
    Color? red500,
    Color? red950,
    Color? amber300,
  }) {
    return KoscharkhColors(
      primary: primary ?? this.primary,
      onPrimary: onPrimary ?? this.onPrimary,
      surface: surface ?? this.surface,
      surfaceMuted: surfaceMuted ?? this.surfaceMuted,
      onSurface: onSurface ?? this.onSurface,
      onSurfaceMuted: onSurfaceMuted ?? this.onSurfaceMuted,
      border: border ?? this.border,
      error: error ?? this.error,
      onError: onError ?? this.onError,
      success: success ?? this.success,
      warning: warning ?? this.warning,
      disabled: disabled ?? this.disabled,
      onDisabled: onDisabled ?? this.onDisabled,
      scrim: scrim ?? this.scrim,
      green300: green300 ?? this.green300,
      green400: green400 ?? this.green400,
      green500: green500 ?? this.green500,
      green900: green900 ?? this.green900,
      neutral100: neutral100 ?? this.neutral100,
      neutral400: neutral400 ?? this.neutral400,
      neutral700: neutral700 ?? this.neutral700,
      neutral900: neutral900 ?? this.neutral900,
      blackSurface: blackSurface ?? this.blackSurface,
      red300: red300 ?? this.red300,
      red500: red500 ?? this.red500,
      red950: red950 ?? this.red950,
      amber300: amber300 ?? this.amber300,
    );
  }

  @override
  KoscharkhColors lerp(ThemeExtension<KoscharkhColors>? other, double t) {
    if (other is! KoscharkhColors) {
      return this;
    }
    Color lerpColor(Color a, Color b) => Color.lerp(a, b, t)!;
    return KoscharkhColors(
      primary: lerpColor(primary, other.primary),
      onPrimary: lerpColor(onPrimary, other.onPrimary),
      surface: lerpColor(surface, other.surface),
      surfaceMuted: lerpColor(surfaceMuted, other.surfaceMuted),
      onSurface: lerpColor(onSurface, other.onSurface),
      onSurfaceMuted: lerpColor(onSurfaceMuted, other.onSurfaceMuted),
      border: lerpColor(border, other.border),
      error: lerpColor(error, other.error),
      onError: lerpColor(onError, other.onError),
      success: lerpColor(success, other.success),
      warning: lerpColor(warning, other.warning),
      disabled: lerpColor(disabled, other.disabled),
      onDisabled: lerpColor(onDisabled, other.onDisabled),
      scrim: lerpColor(scrim, other.scrim),
      green300: lerpColor(green300, other.green300),
      green400: lerpColor(green400, other.green400),
      green500: lerpColor(green500, other.green500),
      green900: lerpColor(green900, other.green900),
      neutral100: lerpColor(neutral100, other.neutral100),
      neutral400: lerpColor(neutral400, other.neutral400),
      neutral700: lerpColor(neutral700, other.neutral700),
      neutral900: lerpColor(neutral900, other.neutral900),
      blackSurface: lerpColor(blackSurface, other.blackSurface),
      red300: lerpColor(red300, other.red300),
      red500: lerpColor(red500, other.red500),
      red950: lerpColor(red950, other.red950),
      amber300: lerpColor(amber300, other.amber300),
    );
  }
}

@immutable
class KoscharkhSpacing extends ThemeExtension<KoscharkhSpacing> {
  const KoscharkhSpacing({
    required this.xs,
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
    required this.xxl,
  });

  final double xs;
  final double sm;
  final double md;
  final double lg;
  final double xl;
  final double xxl;

  @override
  KoscharkhSpacing copyWith({
    double? xs,
    double? sm,
    double? md,
    double? lg,
    double? xl,
    double? xxl,
  }) {
    return KoscharkhSpacing(
      xs: xs ?? this.xs,
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      xl: xl ?? this.xl,
      xxl: xxl ?? this.xxl,
    );
  }

  @override
  KoscharkhSpacing lerp(ThemeExtension<KoscharkhSpacing>? other, double t) {
    if (other is! KoscharkhSpacing) {
      return this;
    }
    return KoscharkhSpacing(
      xs: lerpDouble(xs, other.xs, t),
      sm: lerpDouble(sm, other.sm, t),
      md: lerpDouble(md, other.md, t),
      lg: lerpDouble(lg, other.lg, t),
      xl: lerpDouble(xl, other.xl, t),
      xxl: lerpDouble(xxl, other.xxl, t),
    );
  }
}

@immutable
class KoscharkhRadius extends ThemeExtension<KoscharkhRadius> {
  const KoscharkhRadius({
    required this.sm,
    required this.md,
    required this.lg,
    required this.pill,
  });

  final double sm;
  final double md;
  final double lg;
  final double pill;

  @override
  KoscharkhRadius copyWith({double? sm, double? md, double? lg, double? pill}) {
    return KoscharkhRadius(
      sm: sm ?? this.sm,
      md: md ?? this.md,
      lg: lg ?? this.lg,
      pill: pill ?? this.pill,
    );
  }

  @override
  KoscharkhRadius lerp(ThemeExtension<KoscharkhRadius>? other, double t) {
    if (other is! KoscharkhRadius) {
      return this;
    }
    return KoscharkhRadius(
      sm: lerpDouble(sm, other.sm, t),
      md: lerpDouble(md, other.md, t),
      lg: lerpDouble(lg, other.lg, t),
      pill: lerpDouble(pill, other.pill, t),
    );
  }
}

double lerpDouble(double a, double b, double t) => a + (b - a) * t;

const koscharkhDarkColors = KoscharkhColors(
  primary: Color(0xFF34D399),
  onPrimary: Color(0xFF064E3B),
  surface: Color(0xFF15171C),
  surfaceMuted: Color(0xFF20232A),
  onSurface: Color(0xFFF2F4F8),
  onSurfaceMuted: Color(0xFFA8AFBC),
  border: Color(0xFF343943),
  error: Color(0xFFFF8D93),
  onError: Color(0xFF4A080D),
  success: Color(0xFF6EE7B7),
  warning: Color(0xFFFFBF66),
  disabled: Color(0xFF2C3038),
  onDisabled: Color(0xFF747B88),
  scrim: Color(0x99000000),
  green300: Color(0xFF6EE7B7),
  green400: Color(0xFF34D399),
  green500: Color(0xFF10B981),
  green900: Color(0xFF064E3B),
  neutral100: Color(0xFFF2F4F8),
  neutral400: Color(0xFFA8AFBC),
  neutral700: Color(0xFF343943),
  neutral900: Color(0xFF20232A),
  blackSurface: Color(0xFF15171C),
  red300: Color(0xFFFF8D93),
  red500: Color(0xFFC62828),
  red950: Color(0xFF4A080D),
  amber300: Color(0xFFFFBF66),
);

const koscharkhSpacing = KoscharkhSpacing(
  xs: 4,
  sm: 8,
  md: 12,
  lg: 16,
  xl: 24,
  xxl: 32,
);

const koscharkhRadius = KoscharkhRadius(sm: 8, md: 12, lg: 16, pill: 999);

ThemeData buildKoscharkhDarkTheme() {
  const colors = koscharkhDarkColors;
  // TODO: Bundle JetBrains Mono font files when the final app assets are supplied.
  const fontFamily = 'JetBrains Mono';
  const fallback = ['monospace'];

  TextStyle base({
    required double size,
    required FontWeight weight,
    required double height,
    Color color = const Color(0xFFF2F4F8),
  }) {
    return TextStyle(
      color: color,
      fontFamily: fontFamily,
      fontFamilyFallback: fallback,
      fontSize: size,
      fontWeight: weight,
      height: height,
      letterSpacing: 0,
    );
  }

  final textTheme = TextTheme(
    titleLarge: base(size: 20, weight: FontWeight.w500, height: 1.3),
    bodyLarge: base(size: 16, weight: FontWeight.w400, height: 1.45),
    bodyMedium: base(size: 16, weight: FontWeight.w400, height: 1.45),
    labelLarge: base(size: 15, weight: FontWeight.w500, height: 1.2),
    bodySmall: base(size: 12, weight: FontWeight.w400, height: 1.35),
  );

  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: colors.surface,
    colorScheme: ColorScheme.dark(
      primary: colors.primary,
      onPrimary: colors.onPrimary,
      surface: colors.surface,
      onSurface: colors.onSurface,
      error: colors.error,
      onError: colors.onError,
    ),
    textTheme: textTheme,
    inputDecorationTheme: const InputDecorationTheme(border: InputBorder.none),
    extensions: const [colors, koscharkhSpacing, koscharkhRadius],
  );
}

extension KoscharkhThemeX on BuildContext {
  KoscharkhColors get colors =>
      Theme.of(this).extension<KoscharkhColors>() ?? koscharkhDarkColors;
  KoscharkhSpacing get spacing =>
      Theme.of(this).extension<KoscharkhSpacing>() ?? koscharkhSpacing;
  KoscharkhRadius get radius =>
      Theme.of(this).extension<KoscharkhRadius>() ?? koscharkhRadius;
}
