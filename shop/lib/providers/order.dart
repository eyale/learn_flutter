import 'package:flutter/material.dart';

import './cart.dart';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem({
    required this.id,
    required this.amount,
    required this.products,
    required this.dateTime,
  });
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  int get count {
    return _orders.length;
  }

  void addOrder({
    required List<CartItem> products,
    required double totalAmount,
  }) {
    _orders.insert(
        0,
        OrderItem(
          id: DateTime.now().toString(),
          amount: totalAmount,
          products: products,
          dateTime: DateTime.now(),
        ));

    notifyListeners();
  }
}
