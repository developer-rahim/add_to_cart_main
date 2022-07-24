import 'package:flutter/material.dart';

import '../Database/db_helper.dart';
import '../Model/data_base_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartCounter extends ChangeNotifier {
  int _counter = 0;
  int get counter => _counter;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  incrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _counter = ((prefs.getInt('counter') ?? 0) + 1);

    prefs.setInt('counter', _counter);
    notifyListeners();
  }

  decrementCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (counter != 0) {
      _counter = ((prefs.getInt('counter') ?? 0) - 1);
      prefs.setInt('counter', _counter);
    }
    notifyListeners();
  }

  loadCounter() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    _counter = (prefs.getInt('counter') ?? 0);
    notifyListeners();
  }

  void _setPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setDouble('cart_items', _totalPrice);
    notifyListeners();
  }

  void _getPrefItem() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.getDouble(
          'cart_items',
        ) ??
        0.0;
    notifyListeners();
  }

  void addTotalPrice(double productPrice) {
    _totalPrice = _totalPrice + productPrice;
    _setPrefItem();
    notifyListeners();
  }

  void removeTotalPrice(double productPrice) {
    _totalPrice = _totalPrice - productPrice;
    _setPrefItem();
    notifyListeners();
  }

  double getTotalPrice() {
    _getPrefItem();
    return _totalPrice;
  }
}
