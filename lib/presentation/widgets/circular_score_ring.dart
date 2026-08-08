import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';

class CircularScoreRing extends StatelessWidget {
  const CircularScoreRing({
    super.key,
    required this.score,
    this.size = 256,
    this.subtitle = 'Speaking Score',
    this.deltaLabel,
    this.progress,
  });

  final int score;
  final double size;
  final String subtitle;
  final String? deltaLabel;
  final double? progress;

  @override
  Widget build(BuildContext context) {
    final value = (progress ?? score / 100).clamp(0.0, 1.0);

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomPaint(
            size: Size(size, size),
            painter: _ScoreRingPainter(progress: value),
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (subtitle.isNotEmpty) ...[
                Text(
                  subtitle.toUpperCase(),
                  style: AppTypography.labelMd.copyWith(
                    letterSpacing: 1.2,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
              ],
              Text('$score', style: AppTypography.displayScore),
              if (deltaLabel != null) ...[
                const SizedBox(height: 4),
                Text(
                  deltaLabel!,
                  style: AppTypography.labelMd.copyWith(
                    color: AppColors.primary,
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

class _ScoreRingPainter extends CustomPainter {
  _ScoreRingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 8;
    const stroke = 4.0;

    final track = Paint()
      ..color = AppColors.surfaceContainer
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    final arc = Paint()
      ..shader = const SweepGradient(
        startAngle: -math.pi / 2,
        endAngle: 3 * math.pi / 2,
        colors: [AppColors.primaryDim, AppColors.primary],
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, track);

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      arc,
    );
  }

  @override
  bool shouldRepaint(covariant _ScoreRingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
