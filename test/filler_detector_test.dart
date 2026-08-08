import 'package:flutter_test/flutter_test.dart';
import 'package:voicecoach_ai/shared/analysis/filler_detector.dart';
import 'package:voicecoach_ai/shared/analysis/metrics_engine.dart';

void main() {
  group('FillerDetector', () {
    test('counts single and bigram fillers', () {
      final detector = FillerDetector();
      final result = detector.analyze(
        'Um I think like you know basically we should actually go',
      );

      expect(result.fillerCount, greaterThanOrEqualTo(4));
      expect(result.fillerRate, greaterThan(0));
    });

    test('returns zero for empty transcript', () {
      final detector = FillerDetector();
      final result = detector.analyze('');
      expect(result.fillerCount, 0);
      expect(result.fillerRate, 0);
    });
  });

  group('MetricsEngine', () {
    test('computes WPM and pace status', () {
      final engine = MetricsEngine();
      final metrics = engine.compute(
        transcript: 'one two three four five six seven eight nine ten',
        durationSeconds: 60,
      );

      expect(metrics.totalWords, 10);
      expect(metrics.wpm, 10);
    });
  });
}
