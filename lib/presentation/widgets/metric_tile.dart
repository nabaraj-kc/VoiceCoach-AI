import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/theme/app_decorations.dart';

class MetricTile extends StatelessWidget {
  const MetricTile({
    super.key,
    required this.label,
    required this.value,
    required this.subtitle,
    required this.icon,
    this.accentColor = AppColors.primary,
  });

  final String label;
  final String value;
  final String subtitle;
  final IconData icon;
  final Color accentColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerPadding),
      decoration: AppDecorations.surfaceCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTypography.labelSm),
              Icon(icon, size: 18, color: accentColor),
            ],
          ),
          const SizedBox(height: AppSpacing.base),
          Text(value, style: AppTypography.headlineLg.copyWith(fontSize: 28)),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: AppTypography.labelSm.copyWith(color: accentColor),
          ),
        ],
      ),
    );
  }
}
