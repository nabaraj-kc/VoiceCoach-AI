import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';

abstract final class AppTypography {
  static TextTheme textTheme = TextTheme(
    displayLarge: GoogleFonts.inter(
      fontSize: 64,
      height: 72 / 64,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.04 * 64,
      color: AppColors.onSurface,
    ),
    headlineLarge: GoogleFonts.inter(
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w700,
      letterSpacing: -0.02 * 32,
      color: AppColors.onSurface,
    ),
    headlineMedium: GoogleFonts.inter(
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.01 * 24,
      color: AppColors.onSurface,
    ),
    titleLarge: GoogleFonts.inter(
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w600,
      color: AppColors.onSurface,
    ),
    bodyLarge: GoogleFonts.inter(
      fontSize: 18,
      height: 28 / 18,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurface,
    ),
    bodyMedium: GoogleFonts.inter(
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: AppColors.onSurface,
    ),
    labelLarge: GoogleFonts.inter(
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w500,
      letterSpacing: 0.01 * 14,
      color: AppColors.onSurfaceVariant,
    ),
    labelSmall: GoogleFonts.inter(
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.05 * 12,
      color: AppColors.onSurfaceVariant,
    ),
  );

  static TextStyle get displayScore => textTheme.displayLarge!;
  static TextStyle get headlineLg => textTheme.headlineLarge!;
  static TextStyle get headlineMd => textTheme.headlineMedium!;
  static TextStyle get bodyLg => textTheme.bodyLarge!;
  static TextStyle get bodyMd => textTheme.bodyMedium!;
  static TextStyle get labelMd => textTheme.labelLarge!;
  static TextStyle get labelSm => textTheme.labelSmall!;
}
