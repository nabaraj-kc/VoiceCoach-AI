import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:voicecoach_ai/presentation/theme/app_theme.dart';
import 'package:voicecoach_ai/features/home/home_screen.dart';
import 'package:voicecoach_ai/features/progress/progress_screen.dart';
import 'package:voicecoach_ai/features/results/result_screen.dart';
import 'package:voicecoach_ai/features/session/recording_screen.dart';

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/session',
      builder: (context, state) => const RecordingScreen(),
    ),
    GoRoute(
      path: '/result/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return ResultScreen(sessionId: id);
      },
    ),
    GoRoute(
      path: '/progress',
      builder: (context, state) => const ProgressScreen(),
    ),
  ],
);

class VoiceCoachApp extends StatelessWidget {
  const VoiceCoachApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'VoiceCoach AI',
      debugShowCheckedModeBanner: false,
      theme: VoiceCoachTheme.dark,
      routerConfig: _router,
    );
  }
}
