import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';

class AiVisualizer extends StatefulWidget {
  const AiVisualizer({super.key, this.size = 192});

  final double size;

  @override
  State<AiVisualizer> createState() => _AiVisualizerState();
}

class _AiVisualizerState extends State<AiVisualizer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final scale = 0.85 + (_controller.value * 0.15);
          return Stack(
            alignment: Alignment.center,
            children: [
              _PulseRing(scale: scale, opacity: 0.3, inset: 0),
              _PulseRing(
                scale: scale * 0.95,
                opacity: 0.5,
                inset: 12,
                delay: 0.5,
              ),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: AppColors.primaryGradient,
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.4),
                      blurRadius: 40,
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.graphic_eq_rounded,
                  color: AppColors.surfaceContainerLowest,
                  size: 36,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _PulseRing extends StatelessWidget {
  const _PulseRing({
    required this.scale,
    required this.opacity,
    required this.inset,
    this.delay = 0,
  });

  final double scale;
  final double opacity;
  final double inset;
  final double delay;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: scale,
      child: Container(
        margin: EdgeInsets.all(inset),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.primary.withValues(alpha: opacity),
            width: 1,
          ),
        ),
      ),
    );
  }
}
