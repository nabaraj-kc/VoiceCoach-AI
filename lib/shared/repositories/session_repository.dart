import 'package:voicecoach_ai/shared/models/session_model.dart';

abstract class SessionRepository {
  Future<void> init();
  Future<void> save(SessionModel session);
  Future<SessionModel?> getById(String id);
  Future<List<SessionModel>> getAll();
  Future<SessionModel?> getLatest();
  int calculateStreak();
}
