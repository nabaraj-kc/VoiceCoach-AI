import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/widgets/glass_card.dart';

class PracticeStatusCard extends StatelessWidget {
  const PracticeStatusCard({
    super.key,
    this.minutesCompleted = 0,
    this.minutesGoal = 15,
  });

  final int minutesCompleted;
  final int minutesGoal;

  @override
  Widget build(BuildContext context) {
    return GlassCard(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: AppColors.surfaceContainerHigh,
                width: 2,
              ),
            ),
            child: Icon(
              Icons.mic_none_rounded,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Practice",
                  style: AppTypography.bodyLg.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  '$minutesCompleted / $minutesGoal mins completed',
                  style: AppTypography.labelMd,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
