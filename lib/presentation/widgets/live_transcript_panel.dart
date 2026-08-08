import 'package:flutter/material.dart';
import 'package:voicecoach_ai/core/constants/speech_constants.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';

class LiveTranscriptPanel extends StatelessWidget {
  const LiveTranscriptPanel({
    super.key,
    required this.transcript,
    this.placeholder = 'AI: Listening for your response...',
  });

  final String transcript;
  final String placeholder;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 128,
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow.withValues(alpha: 0.3),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderFaint()),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: 32,
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      AppColors.surfaceContainerLow.withValues(alpha: 0.5),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
            ListView(
              padding: const EdgeInsets.all(16),
              children: [
                if (transcript.isEmpty)
                  Text(
                    placeholder,
                    style: AppTypography.bodyMd.copyWith(
                      color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
                      fontStyle: FontStyle.italic,
                      fontSize: 14,
                    ),
                  )
                else
                  _HighlightedTranscript(text: transcript),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _HighlightedTranscript extends StatelessWidget {
  const _HighlightedTranscript({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final spans = <InlineSpan>[];
    final words = text.split(RegExp(r'(\s+)'));

    for (final part in words) {
      final lower = part.toLowerCase().replaceAll(RegExp(r'[^\w]'), '');
      final isFiller = kFillerWords.contains(lower) ||
          kFillerWords.contains(part.toLowerCase().trim());

      if (isFiller && part.trim().isNotEmpty) {
        spans.add(
          WidgetSpan(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 1),
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 1),
              decoration: BoxDecoration(
                color: AppColors.tertiary.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                part,
                style: AppTypography.bodyMd.copyWith(
                  color: AppColors.tertiary,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: part,
            style: AppTypography.bodyMd.copyWith(
              color: AppColors.onSurface,
              fontSize: 14,
              height: 1.5,
            ),
          ),
        );
      }
    }

    return RichText(text: TextSpan(children: spans));
  }
}
