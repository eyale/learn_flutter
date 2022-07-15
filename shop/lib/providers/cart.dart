import 'package:flutter/material.dart';

import './product.dart';

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}

class Cart with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get count {
    int count = 0;
    _items.forEach((key, value) {
      count += value.quantity;
    });
    return count;
  }

  double get totalAmount {
    double amount = 0;
    _items.forEach((key, value) {
      amount += value.price * value.quantity;
    });
    return amount;
  }

  void toggleCartItem({required Product product}) {
    if (_items.containsKey(product.id)) {
      _items.remove(product.id);
    } else {
      addCartItem(product: product);
    }
    notifyListeners();
  }

  void removeCartItem({required String productId}) {
    _items.remove(productId);
    notifyListeners();
  }

  void removeLastAdded({required String productId}) {
    if (!_items.containsKey(productId)) return;

    if (_items[productId]!.quantity > 1) {
      _items.update(
          productId,
          (item) => CartItem(
              id: productId,
              title: item.title,
              quantity: item.quantity - 1,
              price: item.price));
    } else {
      _items.remove(productId);
    }
    notifyListeners();
  }

  void addCartItem({required Product product}) {
    if (_items.containsKey(product.id)) {
      _items.update(
          product.id,
          (existingCartItem) => CartItem(
                id: existingCartItem.id,
                title: existingCartItem.title,
                quantity: existingCartItem.quantity + 1,
                price: existingCartItem.price,
              ));
    } else {
      _items.putIfAbsent(
          product.id,
          () => CartItem(
                id: DateTime.now().toString(),
                title: product.title,
                quantity: 1,
                price: product.price,
              ));
    }
    notifyListeners();
  }

  void clear() {
    _items = {};

    notifyListeners();
  }
}
