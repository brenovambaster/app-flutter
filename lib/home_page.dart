import 'package:provider/provider.dart';
import 'controllers/fuel_controller.dart';
import 'package:app1/pages/fuel_page.dart';
import 'package:flutter/material.dart';
import 'counter_page.dart';
import 'reminders_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CounterPage(title: 'Contador'),
    const RemindersPage(),
    ChangeNotifierProvider(
      create: (_) => FuelController(),
      child: const FuelPage(),
    ),
    const Center(child: Text('Revisões')),
    const Center(child: Text('Configurações')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.of(context).pop(); // Fecha o Drawer após clicar
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Caixa de ferramentas')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.add_box),
              title: const Text('Contador'),
              onTap: () => _onItemTapped(0),
            ),
            ListTile(
              leading: const Icon(Icons.add_task),
              title: const Text('Lembretes'),
              onTap: () => _onItemTapped(1),
            ),
            ListTile(
              leading: const Icon(Icons.local_gas_station),
              title: const Text('Combustível'),
              onTap: () => _onItemTapped(2),
            ),
            ListTile(
              leading: const Icon(Icons.motorcycle),
              title: const Text('Revisões'),
              onTap: () => _onItemTapped(3),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Configurações'),
              onTap: () => _onItemTapped(4),
            ),
          ],
        ),
      ),
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
