import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../controllers/counter_controller.dart';
import '../widgets/gradient_app_bar.dart';

class CounterPage extends StatelessWidget {
  final String title;

  const CounterPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    final controller = context.watch<CounterController>();
    return Scaffold(
      appBar: GradientAppBar(title: title),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Você clicou no botão:",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                '${controller.counter}',
                style: const TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent,
                ),
              ),
              const SizedBox(height: 40),
              const Text(
                "Controle os valores com os botões abaixo:",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FloatingActionButton(
              heroTag: 'Decrement',
              backgroundColor: Colors.redAccent,
              tooltip: "Decrementar",
              onPressed: controller.decrement,
              child: const Icon(Icons.remove, size: 30),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              heroTag: "Reset",
              backgroundColor: Colors.white,
              tooltip: "Resetar",
              onPressed: controller.reset,
              child: const Icon(
                Icons.refresh,
                color: Colors.blueAccent,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            FloatingActionButton(
              heroTag: "Increment",
              backgroundColor: Colors.greenAccent,
              tooltip: "Incrementar",
              onPressed: controller.increment,
              child: const Icon(Icons.add, size: 30),
            ),
          ],
        ),
      ),
    );
  }
}
