import 'package:flutter/material.dart';
import 'dart:convert' as convert;

import './cart.dart';

import '../misc/Api.dart';

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

  OrderItem copyWith({
    String? id,
    double? amount,
    List<CartItem>? products,
    DateTime? dateTime,
  }) =>
      OrderItem(
        id: id ?? this.id,
        amount: amount ?? this.amount,
        products: products ?? this.products,
        dateTime: dateTime ?? this.dateTime,
      );
}

class Order with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  int get count {
    return _orders.length;
  }

  Future get() async {
    try {
      final resp = await Api.instance.get(path: 'orders.json');

      if (resp.body == 'null') return;

      final decodedBody = convert.jsonDecode(resp.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrders = [];

      decodedBody.forEach((key, value) {
        loadedOrders.add(
          OrderItem(
            id: key,
            amount: value['amount'],
            products: (value['products'] as List<dynamic>)
                .map((e) => CartItem(
                    id: e['id'],
                    title: e['title'],
                    quantity: e['quantity'],
                    price: e['price']))
                .toList(),
            dateTime: DateTime.parse(value['dateTime']),
          ),
        );
      });

      _orders = loadedOrders.reversed.toList();
      notifyListeners();
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }

  Future add({
    required List<CartItem> products,
    required double totalAmount,
  }) async {
    final orderItem = OrderItem(
      id: DateTime.now().toString(),
      amount: totalAmount,
      products: products,
      dateTime: DateTime.now(),
    );

    final orderItemEncoded = convert.jsonEncode({
      'amount': orderItem.amount,
      'dateTime': orderItem.dateTime.toIso8601String(),
      'products': orderItem.products
          .map((e) => {
                'id': e.id,
                'title': e.title,
                'quantity': e.quantity,
                'price': e.price,
              })
          .toList(),
    });

    final resp = await Api.instance
        .post(path: 'orders.json', jsonEncoded: orderItemEncoded);
    final decodedId = convert.jsonDecode(resp.body);
    _orders.insert(0, orderItem.copyWith(id: decodedId['name']));

    notifyListeners();
  }
}
