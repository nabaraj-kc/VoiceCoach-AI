import 'package:voicecoach_ai/core/constants/speech_constants.dart';
import 'package:voicecoach_ai/core/utils/transcript_utils.dart';

class FillerMatch {
  const FillerMatch({required this.phrase, required this.tokenIndex});

  final String phrase;
  final int tokenIndex;
}

class FillerDetectionResult {
  const FillerDetectionResult({
    required this.fillerCount,
    required this.fillerRate,
    required this.matches,
  });

  final int fillerCount;
  final double fillerRate;
  final List<FillerMatch> matches;
}

class FillerDetector {
  FillerDetectionResult analyze(String transcript) {
    final tokens = tokenizeTranscript(transcript);
    if (tokens.isEmpty) {
      return const FillerDetectionResult(
        fillerCount: 0,
        fillerRate: 0,
        matches: [],
      );
    }

    final matches = <FillerMatch>[];
    final matchedIndices = <int>{};

    for (var i = 0; i < tokens.length; i++) {
      if (i < tokens.length - 1) {
        final bigram = '${tokens[i]} ${tokens[i + 1]}';
        if (kFillerWords.contains(bigram) && !matchedIndices.contains(i)) {
          matches.add(FillerMatch(phrase: bigram, tokenIndex: i));
          matchedIndices.add(i);
          matchedIndices.add(i + 1);
          i++;
          continue;
        }
      }

      if (kFillerWords.contains(tokens[i]) && !matchedIndices.contains(i)) {
        matches.add(FillerMatch(phrase: tokens[i], tokenIndex: i));
        matchedIndices.add(i);
      }
    }

    final fillerCount = matches.length;
    final fillerRate = (fillerCount / tokens.length) * 100;

    return FillerDetectionResult(
      fillerCount: fillerCount,
      fillerRate: fillerRate,
      matches: matches,
    );
  }

  int countNewFillers(
    String previousTranscript,
    String currentTranscript,
  ) {
    final previous = analyze(previousTranscript);
    final current = analyze(currentTranscript);
    return current.fillerCount - previous.fillerCount;
  }
}
