import 'package:flutter_test/flutter_test.dart';
import 'package:voicecoach_ai/shared/analysis/filler_detector.dart';

void main() {
  test('placeholder app test', () {
    final detector = FillerDetector();
    expect(detector.analyze('hello world').fillerCount, 0);
  });
}
