import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/widgets/glass_card.dart';

class BentoStatCard extends StatelessWidget {
  const BentoStatCard({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.iconBackground,
    this.value,
    this.title,
    this.body,
    this.minHeight = 140,
  });

  final IconData icon;
  final Color iconColor;
  final Color iconBackground;
  final String? value;
  final String? title;
  final String? body;
  final double minHeight;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      minHeight: minHeight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: iconBackground,
            ),
            child: Icon(icon, color: iconColor, size: 22),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (value != null)
                Text(value!, style: AppTypography.headlineMd),
              if (title != null)
                Text(
                  title!,
                  style: AppTypography.labelMd,
                ),
              if (body != null) ...[
                const SizedBox(height: AppSpacing.base),
                Text(
                  body!,
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.onSurface,
                    height: 1.3,
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
