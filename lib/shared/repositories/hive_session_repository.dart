import 'package:hive_flutter/hive_flutter.dart';
import 'package:voicecoach_ai/shared/models/session_model.dart';
import 'package:voicecoach_ai/shared/repositories/session_repository.dart';

class HiveSessionRepository implements SessionRepository {
  static const String boxName = 'sessions';

  Box<Map>? _box;

  @override
  Future<void> init() async {
    _box = await Hive.openBox<Map>(boxName);
  }

  Box<Map> get box {
    final box = _box;
    if (box == null) {
      throw StateError('HiveSessionRepository not initialized');
    }
    return box;
  }

  @override
  Future<void> save(SessionModel session) async {
    await box.put(session.id, session.toMap());
  }

  @override
  Future<SessionModel?> getById(String id) async {
    final raw = box.get(id);
    if (raw == null) return null;
    return SessionModel.fromMap(Map<dynamic, dynamic>.from(raw));
  }

  @override
  Future<List<SessionModel>> getAll() async {
    final sessions = box.values
        .map((e) => SessionModel.fromMap(Map<dynamic, dynamic>.from(e)))
        .toList();
    sessions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return sessions;
  }

  @override
  Future<SessionModel?> getLatest() async {
    final all = await getAll();
    if (all.isEmpty) return null;
    return all.first;
  }

  @override
  int calculateStreak() {
    final sessions = box.values
        .map((e) => SessionModel.fromMap(Map<dynamic, dynamic>.from(e)))
        .toList();

    if (sessions.isEmpty) return 0;

    final days = sessions
        .map(
          (s) => DateTime(s.createdAt.year, s.createdAt.month, s.createdAt.day),
        )
        .toSet()
        .toList()
      ..sort((a, b) => b.compareTo(a));

    var streak = 0;
    var cursor = DateTime.now();
    final today = DateTime(cursor.year, cursor.month, cursor.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (!days.contains(today) && !days.contains(yesterday)) {
      return 0;
    }

    if (days.contains(today)) {
      streak = 1;
      cursor = today;
    } else {
      streak = 1;
      cursor = yesterday;
    }

    while (true) {
      final previous = cursor.subtract(const Duration(days: 1));
      if (days.contains(previous)) {
        streak++;
        cursor = previous;
      } else {
        break;
      }
    }

    return streak;
  }
}
