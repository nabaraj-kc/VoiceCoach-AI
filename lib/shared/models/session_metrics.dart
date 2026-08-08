import 'package:voicecoach_ai/shared/models/pace_status.dart';

class SessionMetrics {
  const SessionMetrics({
    required this.totalWords,
    required this.fillerCount,
    required this.fillerRate,
    required this.wpm,
    required this.paceStatus,
  });

  final int totalWords;
  final int fillerCount;
  final double fillerRate;
  final double wpm;
  final PaceStatus paceStatus;

  Map<String, dynamic> toMap() => {
        'totalWords': totalWords,
        'fillerCount': fillerCount,
        'fillerRate': fillerRate,
        'wpm': wpm,
        'paceStatus': paceStatus.index,
      };

  factory SessionMetrics.fromMap(Map<dynamic, dynamic> map) {
    return SessionMetrics(
      totalWords: map['totalWords'] as int? ?? 0,
      fillerCount: map['fillerCount'] as int? ?? 0,
      fillerRate: (map['fillerRate'] as num?)?.toDouble() ?? 0,
      wpm: (map['wpm'] as num?)?.toDouble() ?? 0,
      paceStatus: PaceStatus.values[map['paceStatus'] as int? ?? 0],
    );
  }
}
