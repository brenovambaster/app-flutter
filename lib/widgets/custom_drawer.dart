import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Function(int) onTap;

  const CustomDrawer({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
            onTap: () {
              Navigator.pop(context);
              onTap(0);
            },
          ),
          ListTile(
            leading: const Icon(Icons.add_task),
            title: const Text('Lembretes'),
            onTap: () {
              Navigator.pop(context);
              onTap(1);
            },
          ),
          ListTile(
            leading: const Icon(Icons.local_gas_station),
            title: const Text('Combustível'),
            onTap: () {
              Navigator.pop(context);
              onTap(2);
            },
          ),
          ListTile(
            leading: Icon(Icons.local_pharmacy),
            title: Text('Farmácia'),
            onTap: () {
              Navigator.pop(context);
              onTap(3);
            },
          ),
          ListTile(
            leading: const Icon(Icons.motorcycle),
            title: const Text('Revisões'),
            onTap: () {
              Navigator.pop(context);
              onTap(4);
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configurações'),
            onTap: () {
              Navigator.pop(context);
              onTap(5);
            },
          ),
        ],
      ),
    );
  }
}
