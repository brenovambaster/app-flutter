import 'package:app1/widgets/gradient_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/reminder_controller.dart';
import '../models/reminder_model.dart';
import '../widgets/reminder_tile.dart';
import '../widgets/feedback_snackbar.dart';

class RemindersPage extends StatefulWidget {
  final String title;

  const RemindersPage({super.key, required this.title});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final _titleController = TextEditingController();
  DateTime? _selectedDateTime;

  @override
  void initState() {
    super.initState();
    Provider.of<ReminderController>(context, listen: false).loadReminders();
  }

  void _pickDateTime() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    setState(() {
      _selectedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
    });
  }

  void _saveReminder() async {
    final title = _titleController.text;
    final dateTime = _selectedDateTime;

    if (title.isEmpty || dateTime == null) return;

    final reminder = Reminder(title: title, dateTime: dateTime);

    await Provider.of<ReminderController>(
      context,
      listen: false,
    ).addReminder(reminder);

    showSuccessSnackBar(context, 'Lembrete salvo com sucesso!');

    _titleController.clear();
    setState(() => _selectedDateTime = null);
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<ReminderController>(context);

    return Scaffold(
      appBar: GradientAppBar(title: "Lembretes"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Título do lembrete",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDateTime == null
                        ? "Selecione data e hora"
                        : _selectedDateTime.toString(),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: _pickDateTime,
                ),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: _saveReminder,
              icon: const Icon(Icons.save),
              label: const Text("Salvar Lembrete"),
            ),
            const Divider(height: 32),
            Expanded(
              child: ListView.builder(
                itemCount: controller.reminders.length,
                itemBuilder: (context, index) {
                  return ReminderTile(reminder: controller.reminders[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
