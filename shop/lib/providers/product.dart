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
  String? creatorId;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.isFavorite,
    this.creatorId,
  });

  Future toggleIsFavorite() async {
    final prevStatusIsFavorite = isFavorite;
    isFavorite = !isFavorite;
    notifyListeners();
    try {
      debugPrint('toggleIsFavorite Productid: $id');
      final resp = await Api.instance.update(
          path: 'usersFavorites/${Api.instance.userId}.json',
          jsonEncoded: convert.jsonEncode({id: isFavorite}));

      if (resp.statusCode >= 400) {
        isFavorite = prevStatusIsFavorite;
        throw HttpException('Error while toggling favorites');
      }

      notifyListeners();
    } catch (e) {
      debugPrint('toggleIsFavorite e: $e');
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
      'creatorId': creatorId,
    });
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imageUrl,
    bool? isFavorite,
    String? creatorId,
  }) =>
      Product(
        id: id ?? this.id,
        title: title ?? this.title,
        description: description ?? this.description,
        price: price ?? this.price,
        imageUrl: imageUrl ?? this.imageUrl,
        isFavorite: isFavorite ?? this.isFavorite,
        creatorId: creatorId ?? this.creatorId,
      );
}
