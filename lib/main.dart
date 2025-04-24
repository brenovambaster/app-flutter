import 'package:app1/controllers/counter_controller.dart';
import 'package:app1/controllers/fuel_controller.dart';
import 'package:app1/controllers/reminder_controller.dart';
import 'package:app1/home_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FuelController()),
        ChangeNotifierProvider(create: (_) => CounterController()),
        ChangeNotifierProvider(create: (_) => ReminderController()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.greenAccent),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
