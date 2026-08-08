import 'package:flutter/foundation.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

typedef SpeechResultCallback = void Function(String transcript, bool isFinal);

class SpeechToTextService {
  SpeechToTextService({SpeechToText? speechToText})
      : _speech = speechToText ?? SpeechToText();

  final SpeechToText _speech;
  bool _initialized = false;

  bool get isAvailable => _speech.isAvailable;
  bool get isListening => _speech.isListening;

  Future<bool> initialize() async {
    if (_initialized) return _speech.isAvailable;

    final options = <SpeechConfigOption>[];
    if (kIsWeb) {
      options.add(SpeechToText.webDoNotAggregate);
    }

    _initialized = await _speech.initialize(
      options: options,
      onError: (_) {},
      onStatus: (_) {},
    );
    return _initialized && _speech.isAvailable;
  }

  Future<bool> startListening({
    required SpeechResultCallback onResult,
    Duration listenFor = const Duration(minutes: 10),
  }) async {
    if (!_initialized) {
      final ok = await initialize();
      if (!ok) return false;
    }

    await _speech.listen(
      listenOptions: SpeechListenOptions(
        listenFor: listenFor,
        partialResults: true,
      ),
      onResult: (SpeechRecognitionResult result) {
        onResult(result.recognizedWords, result.finalResult);
      },
    );
    return _speech.isListening;
  }

  Future<void> stopListening() async {
    if (_speech.isListening) {
      await _speech.stop();
    }
  }

  Future<void> cancel() async {
    if (_speech.isListening) {
      await _speech.cancel();
    }
  }
}
