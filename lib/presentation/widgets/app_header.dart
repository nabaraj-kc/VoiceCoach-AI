import 'package:flutter/material.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    this.title = 'VoiceCoach AI',
    this.showAvatar = true,
    this.trailing,
    this.leading,
    this.centerTitle = false,
  });

  final String title;
  final bool showAvatar;
  final Widget? trailing;
  final Widget? leading;
  final bool centerTitle;

  @override
  Size get preferredSize => const Size.fromHeight(64);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.7),
        border: Border(bottom: BorderSide(color: AppColors.borderSubtle())),
      ),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.containerPadding,
            vertical: AppSpacing.stackSm,
          ),
          child: Row(
            children: [
              if (leading != null) ...[
                leading!,
                const SizedBox(width: 8),
              ],
              if (showAvatar) ...[
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.surfaceContainer,
                    border: Border.all(color: AppColors.borderSubtle()),
                    gradient: AppColors.purpleGradient,
                  ),
                  child: const Icon(
                    Icons.person_rounded,
                    color: AppColors.onSurface,
                    size: 22,
                  ),
                ),
                const SizedBox(width: 12),
              ],
              Expanded(
                child: Text(
                  title,
                  style: AppTypography.headlineMd,
                  textAlign: centerTitle ? TextAlign.center : TextAlign.start,
                ),
              ),
              if (trailing != null)
                trailing!
              else
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.settings_outlined),
                  color: AppColors.onSurfaceVariant,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
