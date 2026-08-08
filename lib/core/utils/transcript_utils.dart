List<String> tokenizeTranscript(String transcript) {
  if (transcript.trim().isEmpty) return [];
  return transcript
      .toLowerCase()
      .replaceAll(RegExp(r'[^\w\s]'), ' ')
      .split(RegExp(r'\s+'))
      .where((word) => word.isNotEmpty)
      .toList();
}

double calculateWpm(int totalWords, int durationSeconds) {
  if (durationSeconds <= 0 || totalWords <= 0) return 0;
  final minutes = durationSeconds / 60;
  return totalWords / minutes;
}
