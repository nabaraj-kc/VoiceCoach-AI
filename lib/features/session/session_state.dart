import 'package:voicecoach_ai/shared/models/pace_status.dart';
import 'package:voicecoach_ai/shared/models/session_model.dart';

enum SessionPhase { idle, recording, processing, done, error }

class LiveSessionState {
  const LiveSessionState({
    this.phase = SessionPhase.idle,
    this.transcript = '',
    this.durationSeconds = 0,
    this.fillerCount = 0,
    this.fillerRate = 0,
    this.wpm = 0,
    this.paceStatus = PaceStatus.ideal,
    this.errorMessage,
    this.completedSession,
    this.isRecorderReady = false,
  });

  final SessionPhase phase;
  final String transcript;
  final int durationSeconds;
  final int fillerCount;
  final double fillerRate;
  final double wpm;
  final PaceStatus paceStatus;
  final String? errorMessage;
  final SessionModel? completedSession;
  final bool isRecorderReady;

  LiveSessionState copyWith({
    SessionPhase? phase,
    String? transcript,
    int? durationSeconds,
    int? fillerCount,
    double? fillerRate,
    double? wpm,
    PaceStatus? paceStatus,
    String? errorMessage,
    SessionModel? completedSession,
    bool? isRecorderReady,
    bool clearError = false,
    bool clearSession = false,
  }) {
    return LiveSessionState(
      phase: phase ?? this.phase,
      transcript: transcript ?? this.transcript,
      durationSeconds: durationSeconds ?? this.durationSeconds,
      fillerCount: fillerCount ?? this.fillerCount,
      fillerRate: fillerRate ?? this.fillerRate,
      wpm: wpm ?? this.wpm,
      paceStatus: paceStatus ?? this.paceStatus,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
      completedSession:
          clearSession ? null : (completedSession ?? this.completedSession),
      isRecorderReady: isRecorderReady ?? this.isRecorderReady,
    );
  }
}
