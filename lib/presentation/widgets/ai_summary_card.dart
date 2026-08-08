import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/theme/app_decorations.dart';

class AiSummaryCard extends StatelessWidget {
  const AiSummaryCard({
    super.key,
    required this.summary,
    this.sessionLabel,
    this.onReview,
    this.onExport,
  });

  final String summary;
  final String? sessionLabel;
  final VoidCallback? onReview;
  final VoidCallback? onExport;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerPadding),
      decoration: AppDecorations.surfaceCard().copyWith(
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.psychology_rounded, color: AppColors.tertiary, size: 20),
              const SizedBox(width: 8),
              Text(
                'AI EXECUTIVE SUMMARY',
                style: AppTypography.labelSm.copyWith(letterSpacing: 1),
              ),
              const Spacer(),
              if (sessionLabel != null)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.surfaceVariant,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(sessionLabel!, style: AppTypography.labelSm),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.stackSm),
          Text(
            '"$summary"',
            style: AppTypography.headlineMd.copyWith(height: 1.25),
          ),
          const SizedBox(height: AppSpacing.stackMd),
          Row(
            children: [
              ElevatedButton.icon(
                onPressed: onReview,
                icon: const Icon(Icons.play_arrow_rounded, size: 18),
                label: const Text('Review Audio'),
              ),
              const SizedBox(width: 12),
              OutlinedButton.icon(
                onPressed: onExport,
                icon: const Icon(Icons.ios_share_rounded, size: 18),
                label: const Text('Export'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
