import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../models/reminder_model.dart';

class ReminderController extends ChangeNotifier {
  List<Reminder> _reminders = [];

  List<Reminder> get reminders => _reminders;

  /// Loads the reminders from persistent storage.
  /// It reads the list of reminders from `SharedPreferences`, parses them from JSON,
  /// and updates the internal `_reminders` list.
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
  /// It adds the `Reminder` to the internal list, saves the updated list to persistent storage,
  /// and notifies listeners about the change.
  Future<void> addReminder(Reminder reminder) async {
    _reminders.add(reminder);
    await _saveReminders();
    notifyListeners();
  }

  /// Saves the current list of reminders to persistent storage.
  /// It converts the list of `Reminder` objects to a list of JSON strings,
  /// and saves it to `SharedPreferences`.
  Future<void> _saveReminders() async {
    final prefs = await SharedPreferences.getInstance();
    final data = _reminders.map((r) => json.encode(r.toMap())).toList();
    await prefs.setStringList('reminders', data);
  }

  Future<void> updateReminder(int index, Reminder updatedReminder) async {
    _reminders[index] = updatedReminder;
    await _saveReminders();
    notifyListeners();
  }

  Future<void> deleteReminder(int index) async {
    _reminders.removeAt(index);
    await _saveReminders();
    notifyListeners();
  }
}
