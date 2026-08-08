import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';

class VoiceCoachTheme {
  static ThemeData get dark {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.canvas,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimaryFixed,
        secondary: AppColors.accentPurple,
        onSecondary: AppColors.onSurface,
        surface: AppColors.surface,
        onSurface: AppColors.onSurface,
        error: AppColors.error,
      ),
      textTheme: AppTypography.textTheme,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surface.withValues(alpha: 0.7),
        foregroundColor: AppColors.onSurface,
        elevation: 0,
        centerTitle: false,
        systemOverlayStyle: SystemUiOverlayStyle.light,
        titleTextStyle: AppTypography.headlineMd,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          side: BorderSide(color: AppColors.borderSubtle()),
        ),
      ),
      dividerTheme: DividerThemeData(
        color: AppColors.borderFaint(),
        thickness: 1,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimaryFixed,
          elevation: 0,
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.stackMd,
            vertical: AppSpacing.stackSm + 4,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          ),
          textStyle: AppTypography.headlineMd.copyWith(fontSize: 18),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.onSurface,
          side: BorderSide(color: AppColors.borderSubtle()),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.stackMd,
            vertical: AppSpacing.stackSm,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          ),
          textStyle: AppTypography.labelMd,
        ),
      ),
      iconTheme: const IconThemeData(
        color: AppColors.onSurfaceVariant,
        size: 22,
      ),
    );
  }
}
