import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/shared/models/pace_status.dart';

class PaceIndicatorBar extends StatelessWidget {
  const PaceIndicatorBar({
    super.key,
    required this.status,
    required this.wpm,
  });

  final PaceStatus status;
  final double wpm;

  String get _label {
    switch (status) {
      case PaceStatus.ideal:
        return 'Ideal pace';
      case PaceStatus.caution:
        return 'Adjust pace';
      case PaceStatus.alert:
        return 'Too fast / slow';
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = status.color;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Pace · ${wpm.round()} WPM', style: AppTypography.labelMd),
            Text(
              _label,
              style: AppTypography.labelMd.copyWith(
                color: color,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.base),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: 1,
            minHeight: 8,
            color: color,
            backgroundColor: AppColors.surfaceContainer,
          ),
        ),
      ],
    );
  }
}
