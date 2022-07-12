import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import '../models/http_exception.dart';

import 'product.dart';

import '../misc/Api.dart';

class Products with ChangeNotifier {
  List<Product> _items = [];

  int get count {
    return _items.length;
  }

  List<Product> get items {
    return _items.toList();
  }

  List<Product> get filteredItems {
    return _items.where((element) => element.isFavorite == true).toList();
  }

  Product getBy({required String id}) {
    return _items.firstWhere((element) => element.id == id);
  }

  Future get() async {
    try {
      var response = await Api.instance.get(path: 'products.json');
      debugPrint('response: ${convert.jsonEncode(response.body)}');
      final decodedData =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      List<Product> loadedProducts = [];

      decodedData.forEach((key, value) {
        debugPrint('key,$key, value: $value');

        loadedProducts.add(Product(
            id: key,
            title: value['title'],
            description: value['description'],
            price: value['price'],
            imageUrl: value['imageUrl']));
      });
      _items = loadedProducts;
      notifyListeners();
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }

  Future add(Product product) async {
    final Product newProduct = product.copyWith(id: DateTime.now().toString());

    try {
      var response = await Api.instance
          .post(path: 'products.json', jsonEncoded: newProduct.jsonEncode());
      final id = convert.jsonDecode(response.body);
      final Product copiedProduct = product.copyWith(id: id['name']);

      _items.add(copiedProduct);

      notifyListeners();
    } catch (error) {
      debugPrint('error: $error');
      rethrow;
    }
  }

  Future update({required String byId, required Product withNewProduct}) async {
    final productIndex = _items.indexWhere((element) => element.id == byId);

    try {
      var response = await Api.instance.edit(
          path: 'products/$byId.json',
          jsonEncoded: withNewProduct.jsonEncode());

      if (response.statusCode == 200) {
        if (productIndex >= 0) {
          _items[productIndex] = withNewProduct;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }

  Future delete({required String byId}) async {
    try {
      var response = await Api.instance.delete(path: 'products/$byId.json');
      final indexOfDeletingProduct =
          _items.indexWhere((element) => element.id == byId);
      final deletingProduct = _items[indexOfDeletingProduct];
      _items.removeWhere((element) => element.id == byId);

      if (response.statusCode >= 400) {
        _items.insert(indexOfDeletingProduct, deletingProduct);
        notifyListeners();
        throw HttpException('Error while trying delete product');
      }
    } catch (e) {
      debugPrint('e: $e');
      rethrow;
    }
  }
}
