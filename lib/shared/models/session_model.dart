import 'package:voicecoach_ai/shared/models/coaching_report.dart';
import 'package:voicecoach_ai/shared/models/session_metrics.dart';

class SessionModel {
  const SessionModel({
    required this.id,
    required this.createdAt,
    required this.durationSeconds,
    required this.transcript,
    required this.metrics,
    required this.coachingReport,
    this.audioPath,
  });

  final String id;
  final DateTime createdAt;
  final int durationSeconds;
  final String transcript;
  final String? audioPath;
  final SessionMetrics metrics;
  final CoachingReport coachingReport;

  Map<String, dynamic> toMap() => {
        'id': id,
        'createdAt': createdAt.toIso8601String(),
        'durationSeconds': durationSeconds,
        'transcript': transcript,
        'audioPath': audioPath,
        'metrics': metrics.toMap(),
        'coachingReport': coachingReport.toMap(),
      };

  factory SessionModel.fromMap(Map<dynamic, dynamic> map) {
    return SessionModel(
      id: map['id'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      durationSeconds: map['durationSeconds'] as int? ?? 0,
      transcript: map['transcript'] as String? ?? '',
      audioPath: map['audioPath'] as String?,
      metrics: SessionMetrics.fromMap(
        Map<dynamic, dynamic>.from(map['metrics'] as Map),
      ),
      coachingReport: CoachingReport.fromMap(
        Map<dynamic, dynamic>.from(map['coachingReport'] as Map),
      ),
    );
  }
}
