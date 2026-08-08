import 'package:voicecoach_ai/shared/models/coaching_report.dart';
import 'package:voicecoach_ai/shared/models/session_metrics.dart';

abstract class CoachingService {
  CoachingReport generate({
    required String transcript,
    required SessionMetrics metrics,
    required int durationSeconds,
  });
}
