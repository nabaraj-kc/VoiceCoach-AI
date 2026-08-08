import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_decorations.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';

class GlassCard extends StatelessWidget {
  const GlassCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.stackMd),
    this.minHeight,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final double? minHeight;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      constraints: BoxConstraints(minHeight: minHeight ?? 0),
      padding: padding,
      decoration: AppDecorations.glassCard(),
      child: child,
    );

    if (onTap == null) return card;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        child: card,
      ),
    );
  }
}
