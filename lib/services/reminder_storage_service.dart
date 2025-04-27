import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/reminder_model.dart';

class ReminderStorageService {
  static const _storageKey = 'reminders';

  Future<List<Reminder>> loadReminders() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = prefs.getStringList(_storageKey) ?? [];
      return data.map((item) {
        final map = json.decode(item);
        return Reminder.fromMap(map);
      }).toList();
    } catch (e) {
      print('Erro ao carregar lembretes: $e');
      return [];
    }
  }

  Future<void> saveReminders(List<Reminder> reminders) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final data = reminders.map((r) => json.encode(r.toMap())).toList();
      await prefs.setStringList(_storageKey, data);
    } catch (e) {
      print('Erro ao salvar lembretes: $e');
    }
  }
}
