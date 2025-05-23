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

    // Primeiro limpa o campo de texto
    _titleController.clear();

    // Depois reseta o DateTime via setState
    setState(() {
      _selectedDateTime = null;
    });

    // Salva o lembrete
    await Provider.of<ReminderController>(
      context,
      listen: false,
    ).addReminder(reminder);

    // Mostra feedback ao usuário
    showSuccessSnackBar(context, 'Lembrete salvo com sucesso!');
  }

  void _editReminder(int index, Reminder reminder) {
    _titleController.text = reminder.title;
    _selectedDateTime = reminder.dateTime;

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text("Editar lembrete"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(controller: _titleController),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: _pickDateTime,
                  child: const Text("Selecionar nova data/hora"),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Cancelar"),
              ),
              ElevatedButton(
                onPressed: () async {
                  final updated = Reminder(
                    title: _titleController.text,
                    dateTime: _selectedDateTime ?? reminder.dateTime,
                  );
                  await Provider.of<ReminderController>(
                    context,
                    listen: false,
                  ).updateReminder(index, updated);
                  Navigator.pop(context);
                  showSuccessSnackBar(context, "Lembrete atualizado");
                  _titleController.clear();
                  _selectedDateTime = null;
                },
                child: const Text("Salvar"),
              ),
            ],
          ),
    );
  }

  void _deleteReminder(int index) async {
    await Provider.of<ReminderController>(
      context,
      listen: false,
    ).deleteReminder(index);
    showSuccessSnackBar(context, "Lembrete removido");
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
                  return ReminderTile(
                    reminder: controller.reminders[index],
                    onEdit:
                        () => _editReminder(index, controller.reminders[index]),
                    onDelete: () => _deleteReminder(index),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
