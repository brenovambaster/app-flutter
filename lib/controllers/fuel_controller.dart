import 'package:flutter/material.dart';
import '../models/fuel_result_model.dart';

class FuelController extends ChangeNotifier {
  final alcoholController = TextEditingController();
  final gasolineController = TextEditingController();

  FuelResult? _result;

  FuelResult? get result => _result;

  void calculateBestFuel() {
    final alcohol = double.tryParse(
      alcoholController.text.replaceAll(',', '.'),
    );
    final gasoline = double.tryParse(
      gasolineController.text.replaceAll(',', '.'),
    );

    if (alcohol == 0 || gasoline == 0) return;

    if (alcohol == null || gasoline == null) return;

    final ratio = alcohol / gasoline;
    final recommendation =
        ratio >= 0.7 ? 'Gasolina é mais vantajoso' : 'Álcool é mais vantajoso';

    _result = FuelResult(
      alcoholPrice: alcohol,
      gasolinePrice: gasoline,
      recommendation: recommendation,
    );

    notifyListeners();
  }

  void reset() {
    alcoholController.clear();
    gasolineController.clear();
    _result = null;
    notifyListeners();
  }

  void disposeAll() {
    alcoholController.dispose();
    gasolineController.dispose();
    super.dispose();
  }
}
