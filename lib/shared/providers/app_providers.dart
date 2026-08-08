import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:voicecoach_ai/shared/analysis/filler_detector.dart';
import 'package:voicecoach_ai/shared/analysis/metrics_engine.dart';
import 'package:voicecoach_ai/shared/repositories/hive_session_repository.dart';
import 'package:voicecoach_ai/shared/repositories/session_repository.dart';
import 'package:voicecoach_ai/shared/services/audio_recorder_service.dart';
import 'package:voicecoach_ai/shared/services/coaching_service.dart';
import 'package:voicecoach_ai/shared/services/mock_coaching_service.dart';
import 'package:voicecoach_ai/shared/services/speech_to_text_service.dart';

final sessionRepositoryProvider = Provider<SessionRepository>((ref) {
  return HiveSessionRepository();
});

final speechToTextServiceProvider = Provider<SpeechToTextService>((ref) {
  return SpeechToTextService();
});

final audioRecorderServiceProvider = Provider<AudioRecorderService>((ref) {
  final service = AudioRecorderService();
  ref.onDispose(service.dispose);
  return service;
});

final metricsEngineProvider = Provider<MetricsEngine>((ref) {
  return MetricsEngine();
});

final fillerDetectorProvider = Provider<FillerDetector>((ref) {
  return FillerDetector();
});

final coachingServiceProvider = Provider<CoachingService>((ref) {
  return MockCoachingService();
});

final speechAvailableProvider = FutureProvider<bool>((ref) async {
  final stt = ref.watch(speechToTextServiceProvider);
  return stt.initialize();
});

final sessionHistoryProvider = FutureProvider((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getAll();
});

final streakProvider = Provider<int>((ref) {
  ref.watch(sessionHistoryProvider);
  return ref.read(sessionRepositoryProvider).calculateStreak();
});

final latestSessionProvider = FutureProvider((ref) async {
  final repo = ref.watch(sessionRepositoryProvider);
  return repo.getLatest();
});
