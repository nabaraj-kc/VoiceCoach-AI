import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/theme/app_decorations.dart';
import 'package:voicecoach_ai/presentation/widgets/app_bottom_nav.dart';
import 'package:voicecoach_ai/presentation/widgets/app_header.dart';
import 'package:voicecoach_ai/shared/models/session_model.dart';
import 'package:voicecoach_ai/shared/providers/app_providers.dart';

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(sessionHistoryProvider);

    return Scaffold(
      backgroundColor: AppColors.canvas,
      appBar: const AppHeader(title: 'Progress'),
      bottomNavigationBar: const AppBottomNav(current: AppTab.progress),
      body: historyAsync.when(
        data: (sessions) {
          if (sessions.isEmpty) {
            return Center(
              child: Text(
                'No sessions yet. Complete a session to see trends.',
                style: AppTypography.bodyMd,
                textAlign: TextAlign.center,
              ),
            );
          }

          final chartSessions = sessions.take(10).toList().reversed.toList();

          return ListView(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.containerPadding,
              AppSpacing.stackMd,
              AppSpacing.containerPadding,
              100,
            ),
            children: [
              Text('Trends', style: AppTypography.headlineMd),
              const SizedBox(height: AppSpacing.stackSm),
              _TrendChart(
                sessions: chartSessions,
                metric: _ChartMetric.wpm,
              ),
              const SizedBox(height: AppSpacing.gutter),
              _TrendChart(
                sessions: chartSessions,
                metric: _ChartMetric.fillerRate,
              ),
              const SizedBox(height: AppSpacing.stackLg),
              Text('History', style: AppTypography.headlineMd),
              const SizedBox(height: AppSpacing.stackSm),
              ...sessions.map((session) => _HistoryTile(session: session)),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.session});

  final SessionModel session;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.gutter),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => context.push('/result/${session.id}'),
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          child: Ink(
            decoration: AppDecorations.glassCard(),
            padding: const EdgeInsets.all(AppSpacing.stackMd),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        DateFormat.MMMd().add_jm().format(session.createdAt),
                        style: AppTypography.bodyLg.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Score ${session.coachingReport.score} · '
                        '${session.metrics.wpm.round()} WPM · '
                        '${session.metrics.fillerRate.toStringAsFixed(1)}% fillers',
                        style: AppTypography.labelMd,
                      ),
                    ],
                  ),
                ),
                Text(
                  '${session.coachingReport.score}',
                  style: AppTypography.headlineMd.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(
                  Icons.chevron_right_rounded,
                  color: AppColors.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

enum _ChartMetric { wpm, fillerRate }

class _TrendChart extends StatelessWidget {
  const _TrendChart({required this.sessions, required this.metric});

  final List<SessionModel> sessions;
  final _ChartMetric metric;

  @override
  Widget build(BuildContext context) {
    final spots = <FlSpot>[];
    for (var i = 0; i < sessions.length; i++) {
      final value = metric == _ChartMetric.wpm
          ? sessions[i].metrics.wpm
          : sessions[i].metrics.fillerRate;
      spots.add(FlSpot(i.toDouble(), value));
    }

    final color =
        metric == _ChartMetric.wpm ? AppColors.primary : AppColors.error;
    final title =
        metric == _ChartMetric.wpm ? 'WPM over sessions' : 'Filler %';

    return Container(
      height: 220,
      padding: const EdgeInsets.all(AppSpacing.stackMd),
      decoration: AppDecorations.surfaceCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: AppTypography.labelMd),
          const SizedBox(height: 12),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: spots,
                    isCurved: true,
                    color: color,
                    barWidth: 3,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: color.withValues(alpha: 0.12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
