import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';

class WaveformBars extends StatefulWidget {
  const WaveformBars({
    super.key,
    this.active = true,
    this.barCount = 7,
    this.height = 32,
  });

  final bool active;
  final int barCount;
  final double height;

  @override
  State<WaveformBars> createState() => _WaveformBarsState();
}

class _WaveformBarsState extends State<WaveformBars>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.active) _controller.repeat(reverse: true);
  }

  @override
  void didUpdateWidget(covariant WaveformBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.active && !_controller.isAnimating) {
      _controller.repeat(reverse: true);
    } else if (!widget.active) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: widget.height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: List.generate(widget.barCount, (i) {
          return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              final phase = (_controller.value + i * 0.15) % 1.0;
              final h = widget.active
                  ? 8 + (phase * (widget.height - 8))
                  : 8.0 + (i % 3) * 4;
              final isCenter = i == widget.barCount ~/ 2;
              return Container(
                width: 4,
                height: h,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isCenter && widget.active
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
