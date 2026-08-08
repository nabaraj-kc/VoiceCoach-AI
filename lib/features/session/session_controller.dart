import 'dart:async';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';
import 'package:voicecoach_ai/features/session/session_state.dart';
import 'package:voicecoach_ai/shared/models/session_model.dart';
import 'package:voicecoach_ai/shared/providers/app_providers.dart';
import 'package:voicecoach_ai/shared/services/audio_recorder_service.dart';

final sessionControllerProvider =
    NotifierProvider<SessionController, LiveSessionState>(SessionController.new);

class SessionController extends Notifier<LiveSessionState> {
  Timer? _timer;
  String _previousTranscript = '';
  StreamSubscription<RecordState>? _recorderSub;

  @override
  LiveSessionState build() {
    ref.onDispose(() {
      _timer?.cancel();
      _recorderSub?.cancel();
    });
    return const LiveSessionState();
  }

  Future<void> startSession() async {
    final stt = ref.read(speechToTextServiceProvider);
    final audio = ref.read(audioRecorderServiceProvider);
    final metricsEngine = ref.read(metricsEngineProvider);

    state = state.copyWith(
      phase: SessionPhase.recording,
      clearError: true,
      clearSession: true,
      transcript: '',
      durationSeconds: 0,
      fillerCount: 0,
      fillerRate: 0,
      wpm: 0,
      isRecorderReady: false,
    );

    _previousTranscript = '';

    final sttReady = await stt.initialize();
    if (!sttReady) {
      state = state.copyWith(
        phase: SessionPhase.error,
        errorMessage:
            'Speech recognition is not available on this device or browser. Try Chrome or Edge on web.',
      );
      return;
    }

    _recorderSub?.cancel();
    _recorderSub = audio.stateStream.listen((recordState) {
      final ready = recordState == RecordState.record;
      if (ready != state.isRecorderReady) {
        state = state.copyWith(isRecorderReady: ready);
      }
    });

    final audioStarted = await audio.start();
    if (!audioStarted) {
      state = state.copyWith(
        phase: SessionPhase.error,
        errorMessage: 'Microphone permission denied or unavailable.',
      );
      return;
    }

    final listenStarted = await stt.startListening(
      onResult: (transcript, _) {
        final duration = state.durationSeconds;
        final metrics = metricsEngine.compute(
          transcript: transcript,
          durationSeconds: duration > 0 ? duration : 1,
        );

        final fillerDetector = ref.read(fillerDetectorProvider);
        final newFillers =
            fillerDetector.countNewFillers(_previousTranscript, transcript);
        if (newFillers > 0 && AudioRecorderService.isMobilePlatform()) {
          HapticFeedback.lightImpact();
        }

        _previousTranscript = transcript;

        state = state.copyWith(
          transcript: transcript,
          fillerCount: metrics.fillerCount,
          fillerRate: metrics.fillerRate,
          wpm: metrics.wpm,
          paceStatus: metrics.paceStatus,
        );
      },
    );

    if (!listenStarted) {
      await audio.stop();
      state = state.copyWith(
        phase: SessionPhase.error,
        errorMessage: 'Could not start speech recognition.',
      );
      return;
    }

    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (state.phase != SessionPhase.recording) return;
      final nextDuration = state.durationSeconds + 1;
      final metricsEngine = ref.read(metricsEngineProvider);
      final metrics = metricsEngine.compute(
        transcript: state.transcript,
        durationSeconds: nextDuration,
      );
      state = state.copyWith(
        durationSeconds: nextDuration,
        wpm: metrics.wpm,
        paceStatus: metrics.paceStatus,
        fillerCount: metrics.fillerCount,
        fillerRate: metrics.fillerRate,
      );
    });
  }

  Future<SessionModel?> stopSession() async {
    if (state.phase != SessionPhase.recording) return null;

    state = state.copyWith(phase: SessionPhase.processing);
    _timer?.cancel();
    _recorderSub?.cancel();

    final stt = ref.read(speechToTextServiceProvider);
    final audio = ref.read(audioRecorderServiceProvider);
    final metricsEngine = ref.read(metricsEngineProvider);
    final coaching = ref.read(coachingServiceProvider);
    final repo = ref.read(sessionRepositoryProvider);

    await stt.stopListening();
    final audioPath = await audio.stop();

    final duration = state.durationSeconds > 0 ? state.durationSeconds : 1;
    final metrics = metricsEngine.compute(
      transcript: state.transcript,
      durationSeconds: duration,
    );
    final report = coaching.generate(
      transcript: state.transcript,
      metrics: metrics,
      durationSeconds: duration,
    );

    final session = SessionModel(
      id: const Uuid().v4(),
      createdAt: DateTime.now(),
      durationSeconds: duration,
      transcript: state.transcript,
      audioPath: audioPath,
      metrics: metrics,
      coachingReport: report,
    );

    await repo.save(session);

    state = state.copyWith(
      phase: SessionPhase.done,
      completedSession: session,
    );

    ref.invalidate(sessionHistoryProvider);
    ref.invalidate(latestSessionProvider);

    return session;
  }

  void reset() {
    _timer?.cancel();
    _recorderSub?.cancel();
    state = const LiveSessionState();
  }
}
