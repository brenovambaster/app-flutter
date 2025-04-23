import 'package:app1/reminders_page.dart';
import 'package:flutter/material.dart';

class CounterPage extends StatefulWidget {
  const CounterPage({super.key, required this.title});

  final String title;

  @override
  State<CounterPage> createState() => _CounterPageState();
}

class _CounterPageState extends State<CounterPage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      _counter > 0 ? --_counter : _counter;
    });
  }

  void _resetCounter() {
    setState(() {
      _counter = 0;
    });
  }

  void _navidateToReminders() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RemindersPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColorLight,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),

      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          const SizedBox(height: 16), // Espaço entre os botões
          FloatingActionButton(
            backgroundColor: Colors.red,
            onPressed: _decrementCounter,
            tooltip: 'Decrement',
            child: const Icon(Icons.remove),
          ),

          const SizedBox(height: 16), // Espaço entre os botões
          FloatingActionButton(
            backgroundColor: Colors.white,
            onPressed: _resetCounter,
            tooltip: 'Reset',
            child: const Icon(Icons.refresh),
          ),

          const SizedBox(height: 16), // Espaço entre os botões
          FloatingActionButton(
            backgroundColor: Colors.green,
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),

      // ✅ BottomNavigationBar funcionando de boas
    );
  }
}
