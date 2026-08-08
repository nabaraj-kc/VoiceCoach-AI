import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voicecoach_ai/features/session/session_controller.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/widgets/app_bottom_nav.dart';
import 'package:voicecoach_ai/presentation/widgets/app_header.dart';
import 'package:voicecoach_ai/presentation/widgets/bento_stat_card.dart';
import 'package:voicecoach_ai/presentation/widgets/circular_score_ring.dart';
import 'package:voicecoach_ai/presentation/widgets/gradient_primary_button.dart';
import 'package:voicecoach_ai/presentation/widgets/practice_status_card.dart';
import 'package:voicecoach_ai/shared/providers/app_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final speechAvailable = ref.watch(speechAvailableProvider);
    final latestAsync = ref.watch(latestSessionProvider);
    final streak = ref.watch(streakProvider);

    final score = latestAsync.maybeWhen(
      data: (s) => s?.coachingReport.score ?? 84,
      orElse: () => 84,
    );

    final delta = latestAsync.maybeWhen(
      data: (s) {
        if (s == null) return '+2 pts from last week';
        return 'Last session · ${s.coachingReport.score} pts';
      },
      orElse: () => 'Start your first session',
    );

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: const AppHeader(),
      bottomNavigationBar: const AppBottomNav(current: AppTab.home),
      body: speechAvailable.when(
        data: (available) {
          if (!available) {
            return _UnsupportedBrowser();
          }
          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.containerPadding,
              AppSpacing.stackMd,
              AppSpacing.containerPadding,
              100,
            ),
            children: [
              Center(
                child: CircularScoreRing(
                  score: score,
                  progress: score / 100,
                  deltaLabel: delta,
                ),
              ),
              const SizedBox(height: AppSpacing.stackMd),
              Row(
                children: [
                  Expanded(
                    child: BentoStatCard(
                      icon: Icons.local_fire_department_rounded,
                      iconColor: AppColors.accentPurple,
                      iconBackground:
                          AppColors.accentPurple.withValues(alpha: 0.2),
                      value: '$streak',
                      title: 'Day Streak',
                    ),
                  ),
                  const SizedBox(width: AppSpacing.gutter),
                  Expanded(
                    child: BentoStatCard(
                      icon: Icons.speed_rounded,
                      iconColor: AppColors.primary,
                      iconBackground: AppColors.primary.withValues(alpha: 0.2),
                      body:
                          'Keep practicing daily to improve clarity and pace.',
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.gutter),
              const PracticeStatusCard(),
              const SizedBox(height: AppSpacing.stackMd),
              GradientPrimaryButton(
                label: 'Start Speaking Session',
                onPressed: () {
                  ref.read(sessionControllerProvider.notifier).reset();
                  context.push('/session');
                },
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stackTrace) => ListView(
          padding: const EdgeInsets.all(AppSpacing.containerPadding),
          children: [
            const PracticeStatusCard(),
            const SizedBox(height: AppSpacing.stackMd),
            GradientPrimaryButton(
              label: 'Start Speaking Session',
              onPressed: () {
                ref.read(sessionControllerProvider.notifier).reset();
                context.push('/session');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _UnsupportedBrowser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.containerPadding),
      child: Center(
        child: Text(
          'Speech recognition is not supported in this browser. Use Chrome or Edge on web, or run on Android/iOS.',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
