import 'package:flutter/material.dart';

class RemindersPage extends StatefulWidget {
  const RemindersPage({super.key});

  @override
  State<RemindersPage> createState() => _RemindersPageState();
}

class _RemindersPageState extends State<RemindersPage> {
  final List<String> _reminders = [];

  void _addReminder(String reminder) {
    setState(() {
      _reminders.add(reminder);
    });
  }

  void _clearReminders() {
    setState(() {
      _reminders.clear();
    });
  }

  void _showAddReminderDialog() {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder:
          (_) => AlertDialog(
            insetPadding: EdgeInsets.symmetric(vertical: 40, horizontal: 20),
            title: const Text('Novo lembrete'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Digite o lembrete'),
              keyboardType: TextInputType.text,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancelar'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    _addReminder(controller.text.trim());
                  }
                  Navigator.pop(context);
                },
                child: const Text('Adicionar'),
              ),
            ],
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lembretes'),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body:
          _reminders.isEmpty
              ? const Center(child: Text('Nenhum lembrete ainda.'))
              : ListView.builder(
                itemCount: _reminders.length,
                itemBuilder:
                    (context, index) => ListTile(
                      title: Text(_reminders[index]),
                      leading: const Icon(Icons.alarm),
                    ),
              ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _showAddReminderDialog,
            tooltip: 'Adicionar lembrete',
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16),
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: _clearReminders,
            tooltip: 'Remover todos',
            child: const Icon(Icons.clear_all),
          ),
        ],
      ),
    );
  }
}
