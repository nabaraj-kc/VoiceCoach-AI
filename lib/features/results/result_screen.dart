import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/widgets/ai_summary_card.dart';
import 'package:voicecoach_ai/presentation/widgets/app_bottom_nav.dart';
import 'package:voicecoach_ai/presentation/widgets/circular_score_ring.dart';
import 'package:voicecoach_ai/presentation/widgets/feedback_list_card.dart';
import 'package:voicecoach_ai/presentation/widgets/metric_tile.dart';
import 'package:voicecoach_ai/shared/models/session_model.dart';
import 'package:voicecoach_ai/shared/providers/app_providers.dart';

class ResultScreen extends ConsumerWidget {
  const ResultScreen({super.key, required this.sessionId});

  final String sessionId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final repo = ref.watch(sessionRepositoryProvider);

    return FutureBuilder<SessionModel?>(
      future: repo.getById(sessionId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            backgroundColor: AppColors.canvas,
            body: Center(child: CircularProgressIndicator()),
          );
        }

        final session = snapshot.data;
        if (session == null) {
          return Scaffold(
            backgroundColor: AppColors.canvas,
            appBar: AppBar(title: const Text('Analysis')),
            body: const Center(child: Text('Session not found')),
          );
        }

        final report = session.coachingReport;
        final metrics = session.metrics;
        final summary = report.strength.isNotEmpty
            ? report.strength
            : report.issues.join(' ');

        return Scaffold(
          backgroundColor: AppColors.canvas,
          appBar: AppBar(
            title: const Text('Analysis'),
            automaticallyImplyLeading: true,
          ),
          bottomNavigationBar: const AppBottomNav(current: AppTab.home),
          body: ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.containerPadding,
              AppSpacing.stackMd,
              AppSpacing.containerPadding,
              100,
            ),
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: _ScoreCard(score: report.score),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.stackMd),
              AiSummaryCard(
                summary: summary,
                sessionLabel: DateFormat.MMMd().format(session.createdAt),
                onReview: null,
                onExport: null,
              ),
              const SizedBox(height: AppSpacing.stackMd),
              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                mainAxisSpacing: AppSpacing.gutter,
                crossAxisSpacing: AppSpacing.gutter,
                childAspectRatio: 1.15,
                children: [
                  MetricTile(
                    label: 'Filler Words',
                    value: '${metrics.fillerCount}',
                    subtitle: metrics.fillerRate > 8
                        ? 'Above target'
                        : 'On target',
                    icon: Icons.warning_amber_rounded,
                    accentColor: AppColors.error,
                  ),
                  MetricTile(
                    label: 'Pacing (WPM)',
                    value: '${metrics.wpm.round()}',
                    subtitle: 'Session average',
                    icon: Icons.speed_rounded,
                    accentColor: AppColors.primary,
                  ),
                  MetricTile(
                    label: 'Duration',
                    value: '${session.durationSeconds}s',
                    subtitle: 'Total speaking time',
                    icon: Icons.timer_outlined,
                    accentColor: AppColors.tertiary,
                  ),
                  MetricTile(
                    label: 'Words',
                    value: '${metrics.totalWords}',
                    subtitle: 'Transcript length',
                    icon: Icons.check_circle_outline_rounded,
                    accentColor: AppColors.secondary,
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.stackMd),
              FeedbackListCard(
                title: 'Key Strengths',
                items: [report.strength],
                icon: Icons.thumb_up_rounded,
                accentColor: AppColors.secondary,
              ),
              const SizedBox(height: AppSpacing.gutter),
              FeedbackListCard(
                title: 'Areas for Improvement',
                items: report.issues,
                icon: Icons.trending_up_rounded,
                accentColor: AppColors.tertiary,
              ),
              const SizedBox(height: AppSpacing.gutter),
              FeedbackListCard(
                title: 'Recommended Drill',
                items: [report.drill, ...report.advice],
                icon: Icons.fitness_center_rounded,
                accentColor: AppColors.primary,
              ),
              const SizedBox(height: AppSpacing.stackMd),
              OutlinedButton.icon(
                onPressed: null,
                icon: const Icon(Icons.play_circle_outline_rounded),
                label: const Text('Playback — coming soon'),
              ),
              const SizedBox(height: AppSpacing.stackSm),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Back home'),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ScoreCard extends StatelessWidget {
  const _ScoreCard({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.containerPadding),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainer,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.borderSubtle()),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.05),
            blurRadius: 32,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              'Speaking Score',
              style: AppTypography.labelMd,
            ),
          ),
          const SizedBox(height: AppSpacing.stackSm),
          CircularScoreRing(
            score: score,
            size: 160,
            subtitle: '',
            progress: score / 100,
          ),
          const SizedBox(height: AppSpacing.stackSm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: AppColors.primary.withValues(alpha: 0.2),
              ),
            ),
            child: Text(
              'Session complete',
              style: AppTypography.labelSm.copyWith(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
