import 'package:flutter/material.dart';
import '../models/reminder_model.dart';
import 'package:intl/intl.dart';

class ReminderTile extends StatelessWidget {
  final Reminder reminder;

  const ReminderTile({super.key, required this.reminder});

  @override
  Widget build(BuildContext context) {
    final formatted = DateFormat('dd/MM/yyyy HH:mm').format(reminder.dateTime);

    return ListTile(
      title: Text(reminder.title),
      subtitle: Text(formatted),
      leading: const Icon(Icons.alarm),
    );
  }
}
