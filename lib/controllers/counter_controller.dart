import 'package:flutter/material.dart';

class CounterController extends ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void increment() {
    _counter++;
    notifyListeners();
  }

  void decrement() {
    _counter > 0 ? _counter-- : _counter;
    notifyListeners();
  }

  void reset() {
    _counter = 0;
    notifyListeners();
  }
}
