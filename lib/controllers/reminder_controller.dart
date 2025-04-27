import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/reminder_model.dart';
import '../services/notification_service.dart';

class ReminderController extends ChangeNotifier {
  List<Reminder> _reminders = [];
  final NotificationService _notificationService = NotificationService();

  List<Reminder> get reminders => _reminders;

  ReminderController() {
    _notificationService.initialize(); // Inicializa o serviço de notificação
  }

  /// Loads the reminders from persistent storage.
  Future<void> loadReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = prefs.getStringList('reminders') ?? [];

    _reminders =
        data.map((item) {
          final map = json.decode(item);
          return Reminder.fromMap(map);
        }).toList();

    notifyListeners();
  }

  /// Adds a new `Reminder` to the list.
  Future<void> addReminder(Reminder reminder) async {
    _reminders.add(reminder); // Adiciona o lembrete à lista
    await _saveReminders(); // Salva os lembretes
    notifyListeners(); // Atualiza a UI

    await _notificationService.scheduleNotification(
      reminder,
    ); // Agendar notificação
  }

  /// Saves the current list of reminders to persistent storage.
  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _reminders.map((r) => json.encode(r.toMap())).toList();
    await prefs.setStringList('reminders', data);
  }

  Future<void> updateReminder(int index, Reminder updatedReminder) async {
    _reminders[index] = updatedReminder;
    await _saveReminders();
    notifyListeners();
    await _notificationService.scheduleNotification(
      updatedReminder,
    ); // Agendar notificação após a atualização
  }

  Future<void> deleteReminder(int index) async {
    _reminders.removeAt(index);
    await _saveReminders();
    notifyListeners();
  }
}
