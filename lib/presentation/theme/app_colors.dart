import 'package:flutter/material.dart';

/// Design tokens synced from Stitch — VoiceCoach AI Premium UI.
abstract final class AppColors {
  static const Color canvas = Color(0xFF0B0F1A);
  static const Color surface = Color(0xFF121826);
  static const Color surfaceContainer = Color(0xFF191F2E);
  static const Color surfaceContainerHigh = Color(0xFF242A39);
  static const Color surfaceContainerLow = Color(0xFF151B29);
  static const Color surfaceContainerLowest = Color(0xFF080E1C);
  static const Color surfaceVariant = Color(0xFF2F3544);

  static const Color onSurface = Color(0xFFDDE2F6);
  static const Color onSurfaceVariant = Color(0xFFC0C7D4);
  static const Color outline = Color(0xFF8A919D);
  static const Color outlineVariant = Color(0xFF404752);

  static const Color primary = Color(0xFF4DA3FF);
  static const Color primaryDim = Color(0xFFA2C9FF);
  static const Color onPrimaryFixed = Color(0xFF001C38);

  static const Color accentPurple = Color(0xFF6C5CE7);
  static const Color secondary = Color(0xFFC6BFFF);
  static const Color secondaryContainer = Color(0xFF4029BA);

  static const Color tertiary = Color(0xFFFFB95C);
  static const Color error = Color(0xFFFFB4AB);
  static const Color success = Color(0xFF4ADE80);

  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFD3E4FF), Color(0xFF4DA3FF)],
  );

  static const LinearGradient purpleGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF6C5CE7), Color(0xFF4029BA)],
  );

  static const LinearGradient canvasFade = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [canvas, Color(0x000B0F1A)],
  );

  static Color borderSubtle([double opacity = 0.1]) =>
      Colors.white.withValues(alpha: opacity);

  static Color borderFaint([double opacity = 0.05]) =>
      Colors.white.withValues(alpha: opacity);
}
