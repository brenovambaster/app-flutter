import 'package:flutter/material.dart';
import 'pages/reminders_page.dart';
import 'pages/fuel_page.dart';
import 'pages/counter_page.dart';
import 'widgets/custom_drawer.dart';
import 'pages/pharmacy_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const CounterPage(title: 'Contador'),
    const RemindersPage(title: 'Lembretes'),
    const FuelPage(title: "Combustível"),
    const PharmacyPage(),
    const Center(child: Text('Revisões')),
    const Center(child: Text('Configurações')),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: CustomDrawer(onTap: _onItemTapped),
      body: IndexedStack(index: _selectedIndex, children: _pages),
    );
  }
}
