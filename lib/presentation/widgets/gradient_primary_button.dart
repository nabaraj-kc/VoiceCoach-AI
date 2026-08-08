import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_decorations.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';

class GradientPrimaryButton extends StatelessWidget {
  const GradientPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon = Icons.play_arrow_rounded,
    this.enabled = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData icon;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: AppDecorations.primaryGlow(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: enabled ? onPressed : null,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: Ink(
            decoration: BoxDecoration(
              color: enabled ? AppColors.primary : AppColors.outlineVariant,
              borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withValues(alpha: 0.15),
                  blurRadius: 24,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, color: AppColors.onPrimaryFixed),
                  const SizedBox(width: 8),
                  Text(
                    label,
                    style: AppTypography.headlineMd.copyWith(
                      fontSize: 18,
                      color: AppColors.onPrimaryFixed,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
