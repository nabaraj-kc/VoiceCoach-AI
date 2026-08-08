import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';

class FillerStatsChip extends StatelessWidget {
  const FillerStatsChip({
    super.key,
    required this.count,
    this.goal = 5,
  });

  final int count;
  final int goal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderFaint()),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'TOTAL FILLERS',
                style: AppTypography.labelSm.copyWith(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
              Row(
                children: [
                  Text(
                    '$count',
                    style: AppTypography.headlineMd.copyWith(
                      color: AppColors.tertiary,
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    Icons.warning_amber_rounded,
                    color: AppColors.tertiary.withValues(alpha: 0.5),
                    size: 18,
                  ),
                ],
              ),
            ],
          ),
          Container(
            width: 1,
            height: 32,
            margin: const EdgeInsets.symmetric(horizontal: 16),
            color: AppColors.borderSubtle(0.1),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'GOAL',
                style: AppTypography.labelSm.copyWith(
                  fontSize: 10,
                  color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                ),
              ),
              Text(
                '<$goal',
                style: AppTypography.headlineMd.copyWith(
                  color: AppColors.onSurface.withValues(alpha: 0.4),
                  fontSize: 22,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
