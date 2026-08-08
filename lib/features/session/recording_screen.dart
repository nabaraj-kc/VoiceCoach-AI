import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:voicecoach_ai/features/session/session_controller.dart';
import 'package:voicecoach_ai/features/session/session_state.dart';
import 'package:voicecoach_ai/presentation/theme/app_colors.dart';
import 'package:voicecoach_ai/presentation/theme/app_spacing.dart';
import 'package:voicecoach_ai/presentation/theme/app_typography.dart';
import 'package:voicecoach_ai/presentation/widgets/ai_visualizer.dart';
import 'package:voicecoach_ai/presentation/widgets/coaching_prompt_card.dart';
import 'package:voicecoach_ai/presentation/widgets/filler_stats_chip.dart';
import 'package:voicecoach_ai/presentation/widgets/live_transcript_panel.dart';
import 'package:voicecoach_ai/presentation/widgets/pace_indicator_bar.dart';
import 'package:voicecoach_ai/presentation/widgets/waveform_bars.dart';
import 'package:voicecoach_ai/shared/models/pace_status.dart';

class RecordingScreen extends ConsumerStatefulWidget {
  const RecordingScreen({super.key});

  @override
  ConsumerState<RecordingScreen> createState() => _RecordingScreenState();
}

class _RecordingScreenState extends ConsumerState<RecordingScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(sessionControllerProvider.notifier).startSession();
    });
  }

  String _formatDuration(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  String _paceMessage(PaceStatus status) {
    switch (status) {
      case PaceStatus.ideal:
        return 'Great pacing. Keep this rhythm through your next key point.';
      case PaceStatus.caution:
        return "You're slightly off ideal pace. Pause briefly after important points.";
      case PaceStatus.alert:
        return "You're speaking a bit fast. Try pausing for a second after your next key point.";
    }
  }

  Future<void> _stop() async {
    final session =
        await ref.read(sessionControllerProvider.notifier).stopSession();
    if (!mounted) return;
    if (session != null) {
      context.go('/result/${session.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(sessionControllerProvider);

    ref.listen(sessionControllerProvider, (prev, next) {
      if (next.phase == SessionPhase.error && next.errorMessage != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(next.errorMessage!)),
        );
      }
    });

    if (state.phase == SessionPhase.error) {
      return Scaffold(
        backgroundColor: AppColors.canvas,
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.containerPadding),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  state.errorMessage ?? 'Something went wrong',
                  textAlign: TextAlign.center,
                  style: AppTypography.bodyMd,
                ),
                const SizedBox(height: AppSpacing.stackMd),
                ElevatedButton(
                  onPressed: () => context.go('/'),
                  child: const Text('Back home'),
                ),
              ],
            ),
          ),
        ),
      );
    }

    final isProcessing = state.phase == SessionPhase.processing;
    final isRecording = state.phase == SessionPhase.recording;

    return Scaffold(
      backgroundColor: AppColors.canvas,
      body: Stack(
        children: [
          Positioned.fill(
            child: Center(
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.primary.withValues(alpha: 0.12),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withValues(alpha: 0.2),
                      blurRadius: 120,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.containerPadding,
                    vertical: AppSpacing.stackMd,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          if (isRecording)
                            Container(
                              width: 8,
                              height: 8,
                              margin: const EdgeInsets.only(right: 8),
                              decoration: const BoxDecoration(
                                color: AppColors.error,
                                shape: BoxShape.circle,
                              ),
                            ),
                          Text(
                            _formatDuration(state.durationSeconds),
                            style: AppTypography.labelMd.copyWith(
                              color: AppColors.onSurface,
                            ),
                          ),
                        ],
                      ),
                      TextButton.icon(
                        onPressed: isProcessing ? null : _stop,
                        style: TextButton.styleFrom(
                          backgroundColor:
                              AppColors.error.withValues(alpha: 0.1),
                          foregroundColor: AppColors.error,
                          side: BorderSide(
                            color: AppColors.error.withValues(alpha: 0.2),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(AppSpacing.radiusXl),
                          ),
                        ),
                        icon: const Icon(Icons.call_end_rounded, size: 18),
                        label: Text(
                          isProcessing ? 'Processing…' : 'End Call',
                          style: AppTypography.labelMd.copyWith(
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.containerPadding,
                    ),
                    child: Column(
                      children: [
                        if (!state.isRecorderReady && isRecording)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              'Preparing mic…',
                              style: AppTypography.labelMd,
                            ),
                          ),
                        const AiVisualizer(),
                        const SizedBox(height: AppSpacing.stackMd),
                        FillerStatsChip(count: state.fillerCount),
                        const SizedBox(height: AppSpacing.stackMd),
                        LiveTranscriptPanel(transcript: state.transcript),
                        const SizedBox(height: AppSpacing.stackMd),
                        PaceIndicatorBar(
                          status: state.paceStatus,
                          wpm: state.wpm,
                        ),
                        const SizedBox(height: AppSpacing.stackMd),
                        CoachingPromptCard(
                          title: 'Pacing Suggestion',
                          message: _paceMessage(state.paceStatus),
                        ),
                        const SizedBox(height: 120),
                      ],
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.containerPadding,
                    AppSpacing.stackMd,
                    AppSpacing.containerPadding,
                    AppSpacing.stackMd,
                  ),
                  decoration: BoxDecoration(
                    gradient: AppColors.canvasFade,
                  ),
                  child: Column(
                    children: [
                      WaveformBars(active: isRecording),
                      const SizedBox(height: AppSpacing.stackMd),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _ControlButton(
                            icon: Icons.mic_rounded,
                            onTap: () {},
                          ),
                          const SizedBox(width: AppSpacing.gutter),
                          _ControlButton(
                            icon: Icons.videocam_off_rounded,
                            enabled: false,
                            onTap: null,
                          ),
                          const SizedBox(width: AppSpacing.gutter),
                          _ControlButton(
                            icon: Icons.volume_up_rounded,
                            onTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  const _ControlButton({
    required this.icon,
    this.onTap,
    this.enabled = true,
  });

  final IconData icon;
  final VoidCallback? onTap;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: enabled
          ? AppColors.surfaceContainerHigh.withValues(alpha: 0.8)
          : AppColors.surfaceContainerLowest.withValues(alpha: 0.5),
      shape: const CircleBorder(),
      child: InkWell(
        onTap: enabled ? onTap : null,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          height: 56,
          child: Icon(
            icon,
            color: enabled
                ? AppColors.onSurface
                : AppColors.onSurfaceVariant.withValues(alpha: 0.5),
          ),
        ),
      ),
    );
  }
}
