class CoachingReport {
  const CoachingReport({
    required this.score,
    required this.strength,
    required this.issues,
    required this.advice,
    required this.drill,
  });

  final int score;
  final String strength;
  final List<String> issues;
  final List<String> advice;
  final String drill;

  Map<String, dynamic> toMap() => {
        'score': score,
        'strength': strength,
        'issues': issues,
        'advice': advice,
        'drill': drill,
      };

  factory CoachingReport.fromMap(Map<dynamic, dynamic> map) {
    return CoachingReport(
      score: map['score'] as int? ?? 0,
      strength: map['strength'] as String? ?? '',
      issues: (map['issues'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      advice: (map['advice'] as List<dynamic>? ?? [])
          .map((e) => e.toString())
          .toList(),
      drill: map['drill'] as String? ?? '',
    );
  }
}
