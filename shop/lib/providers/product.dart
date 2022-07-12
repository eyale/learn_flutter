import 'dart:convert' as convert;

import '../misc/Api.dart';
import '../models/http_exception.dart';

import 'package:flutter/material.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
  });

  Future toggleIsFavorite() async {
    final prevStatusIsFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      final resp = await Api.instance
          .update(path: 'products/$id.json', jsonEncoded: jsonEncode());

      if (resp.statusCode >= 400) {
        isFavorite = prevStatusIsFavorite;
        throw HttpException('Error while toggling favorites');
      }

      notifyListeners();
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }

  String jsonEncode() {
    return convert.jsonEncode({
      'title': title,
      'id': id,
      'description': description,
      'price': price,
      'imageUrl': imageUrl,
      'isFavorite': isFavorite,
    });
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavorite: isFavorite ?? this.isFavorite,
      );
}
