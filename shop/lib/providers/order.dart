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

const List<OrderItem> emptyList = [];

class Order with ChangeNotifier {
  List<OrderItem> localOrders = [];

  String? authToken;

  Order({this.authToken, this.localOrders = emptyList});

  List<OrderItem> get orders {
    return [...localOrders];
  }

  int get count {
    return localOrders.length;
  }

  Future get() async {
    try {
      Map<String, dynamic> params = {'auth': authToken};
      final resp = await Api.instance.get(path: 'orders.json', params: params);

      debugPrint('\n\nresp.body: ${resp.body}');
      if (resp.body == 'null') return;

      final decodedBody = convert.jsonDecode(resp.body) as Map<String, dynamic>;
      List<OrderItem> loadedOrders = [];

      decodedBody.forEach((key, value) {
        debugPrint('key: $key');
        debugPrint('value: $value');

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

      localOrders = loadedOrders.reversed.toList();
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
    Map<String, dynamic> params = {'auth': authToken};
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

    final resp = await Api.instance.post(
        path: 'orders.json', encodedBody: orderItemEncoded, params: params);
    final decodedId = convert.jsonDecode(resp.body);
    localOrders.insert(0, orderItem.copyWith(id: decodedId['name']));

    notifyListeners();
  }
}
