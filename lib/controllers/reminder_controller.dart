import 'package:flutter/material.dart';
import '../models/reminder_model.dart';
import '../services/notification_service.dart';
import '../services/reminder_storage_service.dart';

class ReminderController extends ChangeNotifier {
  List<Reminder> _reminders = [];

  final NotificationService _notificationService;
  final ReminderStorageService _storageService;

  List<Reminder> get reminders => _reminders;

  ReminderController({
    required NotificationService notificationService,
    required ReminderStorageService storageService,
  }) : _notificationService = notificationService,
       _storageService = storageService;

  Future<void> initialize() async {
    await _notificationService.initialize();
    await loadReminders();
  }

  Future<void> loadReminders() async {
    _reminders = await _storageService.loadReminders();
    notifyListeners();
  }

  Future<void> addReminder(Reminder reminder) async {
    _reminders.add(reminder);
    await _storageService.saveReminders(_reminders);
    notifyListeners();
    await _notificationService.scheduleNotification(reminder);
  }

  Future<void> updateReminder(int index, Reminder updatedReminder) async {
    _reminders[index] = updatedReminder;
    await _storageService.saveReminders(_reminders);
    notifyListeners();
    await _notificationService.scheduleNotification(updatedReminder);
  }

  Future<void> deleteReminder(int index) async {
    _reminders.removeAt(index);
    await _storageService.saveReminders(_reminders);
    notifyListeners();
  }
}
