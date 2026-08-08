import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

enum RecorderStatus { idle, preparing, recording, stopped }

class AudioRecorderService {
  AudioRecorderService({AudioRecorder? recorder})
      : _recorder = recorder ?? AudioRecorder();

  final AudioRecorder _recorder;
  String? _currentPath;

  Stream<RecordState> get stateStream => _recorder.onStateChanged();

  Future<bool> requestPermission() async {
    if (kIsWeb) {
      return _recorder.hasPermission();
    }
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<bool> start() async {
    final hasPermission = await requestPermission();
    if (!hasPermission) return false;

    if (kIsWeb) {
      await _recorder.start(const RecordConfig(), path: '');
      _currentPath = null;
      return true;
    }

    final dir = await getApplicationDocumentsDirectory();
    final id = const Uuid().v4();
    _currentPath = '${dir.path}/session_$id.m4a';
    await _recorder.start(const RecordConfig(), path: _currentPath!);
    return true;
  }

  Future<String?> stop() async {
    final path = await _recorder.stop();
    if (kIsWeb) {
      return path;
    }
    return _currentPath ?? path;
  }

  Future<void> dispose() async {
    await _recorder.dispose();
  }

  static bool isMobilePlatform() {
    if (kIsWeb) return false;
    return defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;
  }
}
