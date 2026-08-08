import 'package:voicecoach_ai/core/constants/speech_constants.dart';
import 'package:voicecoach_ai/core/utils/transcript_utils.dart';
import 'package:voicecoach_ai/shared/analysis/filler_detector.dart';
import 'package:voicecoach_ai/shared/models/pace_status.dart';
import 'package:voicecoach_ai/shared/models/session_metrics.dart';

class MetricsEngine {
  MetricsEngine({FillerDetector? fillerDetector})
      : _fillerDetector = fillerDetector ?? FillerDetector();

  final FillerDetector _fillerDetector;

  SessionMetrics compute({
    required String transcript,
    required int durationSeconds,
  }) {
    final tokens = tokenizeTranscript(transcript);
    final filler = _fillerDetector.analyze(transcript);
    final wpm = calculateWpm(tokens.length, durationSeconds);

    return SessionMetrics(
      totalWords: tokens.length,
      fillerCount: filler.fillerCount,
      fillerRate: filler.fillerRate,
      wpm: wpm,
      paceStatus: _paceFromWpm(wpm),
    );
  }

  PaceStatus _paceFromWpm(double wpm) {
    if (wpm >= kIdealWpmMin && wpm <= kIdealWpmMax) {
      return PaceStatus.ideal;
    }
    if (wpm >= kYellowWpmLow && wpm <= kYellowWpmHigh) {
      return PaceStatus.caution;
    }
    return PaceStatus.alert;
  }
}
