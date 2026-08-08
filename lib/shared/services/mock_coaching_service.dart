import 'package:voicecoach_ai/core/constants/speech_constants.dart';
import 'package:voicecoach_ai/shared/models/coaching_report.dart';
import 'package:voicecoach_ai/shared/models/session_metrics.dart';
import 'package:voicecoach_ai/shared/services/coaching_service.dart';

class MockCoachingService implements CoachingService {
  @override
  CoachingReport generate({
    required String transcript,
    required SessionMetrics metrics,
    required int durationSeconds,
  }) {
    var score = 85.0;

    if (metrics.fillerRate > kHighFillerRateThreshold) {
      score -= (metrics.fillerRate - kHighFillerRateThreshold) * 1.5;
    }
    if (metrics.wpm > kFastWpmThreshold) {
      score -= (metrics.wpm - kFastWpmThreshold) * 0.15;
    } else if (metrics.wpm < kSlowWpmThreshold && metrics.totalWords > 10) {
      score -= (kSlowWpmThreshold - metrics.wpm) * 0.1;
    }
    if (durationSeconds < 30) {
      score -= 10;
    }

    score = score.clamp(40, 98);

    final issues = <String>[];
    final advice = <String>[];

    if (metrics.fillerRate > kHighFillerRateThreshold) {
      issues.add('Too many filler words (${metrics.fillerRate.toStringAsFixed(1)}%)');
      advice.add("Pause instead of saying 'um' or 'like'");
    }
    if (metrics.wpm > kFastWpmThreshold) {
      issues.add('Speaking slightly fast (${metrics.wpm.round()} WPM)');
      advice.add('Slow down to around 130 WPM');
    } else if (metrics.wpm < kSlowWpmThreshold && metrics.totalWords > 10) {
      issues.add('Speaking slowly (${metrics.wpm.round()} WPM)');
      advice.add('Pick up pace toward 130 WPM for engagement');
    }

    if (issues.isEmpty) {
      issues.add('Minor pacing variations');
      advice.add('Keep practicing short daily sessions');
    }

    final strength = metrics.fillerRate <= 5
        ? 'Clear, confident delivery with few fillers'
        : metrics.wpm >= kIdealWpmMin && metrics.wpm <= kIdealWpmMax
            ? 'Strong pacing within the ideal range'
            : 'Good effort — steady sentence structure';

    final drill = metrics.fillerRate > kHighFillerRateThreshold
        ? '2-minute pause training: speak one sentence, pause 2 seconds, repeat.'
        : '1-minute pace drill: read aloud targeting 130 WPM using a timer.';

    return CoachingReport(
      score: score.round(),
      strength: strength,
      issues: issues,
      advice: advice,
      drill: drill,
    );
  }
}
