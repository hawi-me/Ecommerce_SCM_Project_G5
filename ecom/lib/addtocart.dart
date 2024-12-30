import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  final List<Map<String, dynamic>> _cart = [];

  List<Map<String, dynamic>> get cart => _cart;

  void addToCart(Map<String, dynamic> product) {
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'],
      orElse: () => {},
    );

    if (existingProduct != null) {
      existingProduct['quantity'] += 1;
    } else {
      _cart.add({...product, 'quantity': 1});
    }
    notifyListeners();
  }

  void removeFromCart(Map<String, dynamic> product) {
    final existingProduct = _cart.firstWhere(
      (item) => item['id'] == product['id'],
      orElse: () => {},
    );

    if (existingProduct != null) {
      if (existingProduct['quantity'] > 1) {
        existingProduct['quantity'] -= 1;
      } else {
        _cart.remove(existingProduct);
      }
    }
    notifyListeners();
  }
}
