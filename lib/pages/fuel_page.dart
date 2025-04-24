import 'package:flutter/material.dart';
import '../controllers/fuel_controller.dart';
import 'package:provider/provider.dart';

class FuelPage extends StatelessWidget {
  const FuelPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<FuelController>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Álcool vs Gasolina"),
        backgroundColor: Theme.of(context).primaryColorLight,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Informe os preços:",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: controller.alcoholController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço do Álcool",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_gas_station),
              ),
            ),
            const SizedBox(height: 16),

            TextField(
              controller: controller.gasolineController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Preço da Gasolina",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.local_gas_station_outlined),
              ),
            ),
            const SizedBox(height: 24),

            ElevatedButton.icon(
              onPressed: controller.calculateBestFuel,

              label: const Text("Calcular"),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 24),

            if (controller.result != null) ...[
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Recomendação: ${controller.result!.recommendation}",
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text("Álcool: R\$${controller.result!.alcoholPrice}"),
                      Text("Gasolina: R\$${controller.result!.gasolinePrice}"),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
            ],

            OutlinedButton.icon(
              onPressed: controller.reset,
              icon: const Icon(Icons.restart_alt),
              label: const Text("Resetar"),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                padding: const EdgeInsets.symmetric(vertical: 14),
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
