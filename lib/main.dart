import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:voicecoach_ai/app.dart';
import 'package:voicecoach_ai/shared/providers/app_providers.dart';
import 'package:voicecoach_ai/shared/repositories/hive_session_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  final repository = HiveSessionRepository();
  await repository.init();

  runApp(
    ProviderScope(
      overrides: [
        sessionRepositoryProvider.overrideWithValue(repository),
      ],
      child: const VoiceCoachApp(),
    ),
  );
}
