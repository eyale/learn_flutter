import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import '../models/http_exception.dart';

import 'product.dart';

import '../misc/Api.dart';

const List<Product> emptyList = [];

class Products with ChangeNotifier {
  List<Product> localItems = [];

  String? authToken;

  Products({this.authToken, this.localItems = emptyList});

  int get count {
    return localItems.length;
  }

  List<Product> get items {
    return localItems.toList();
  }

  List<Product> get filteredItems {
    return localItems.where((element) => element.isFavorite == true).toList();
  }

  Product getBy({required String id}) {
    return localItems.firstWhere((element) => element.id == id);
  }

  Future get() async {
    try {
      Map<String, dynamic> params = {'auth': authToken};
      debugPrint('params: $params');

      final response =
          await Api.instance.get(path: 'products.json', params: params);

      if (response.body == 'null') return;

      final decodedBody =
          convert.jsonDecode(response.body) as Map<String, dynamic>;

      List<Product> loadedProducts = [];

      decodedBody.forEach((key, value) {
        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: value['isFavorite'],
        ));
      });
      localItems = loadedProducts;
      notifyListeners();
    } catch (e) {
      debugPrint('get error: $e');
      rethrow;
    }
  }

  Future add(Product product) async {
    final Product newProduct = product.copyWith(id: DateTime.now().toString());

    try {
      final response = await Api.instance
          .post(path: 'products.json', encodedBody: newProduct.jsonEncode());
      final id = convert.jsonDecode(response.body);
      final Product copiedProduct = product.copyWith(id: id['name']);

      localItems.add(copiedProduct);

      notifyListeners();
    } catch (error) {
      debugPrint('add error: $error');
      rethrow;
    }
  }

  Future update({required String byId, required Product withNewProduct}) async {
    final productIndex = localItems.indexWhere((element) => element.id == byId);

    try {
      var response = await Api.instance.update(
          path: 'products/$byId.json',
          jsonEncoded: withNewProduct.jsonEncode());

      if (response.statusCode == 200) {
        if (productIndex >= 0) {
          localItems[productIndex] = withNewProduct;
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint('update error: $e');
      rethrow;
    }
  }

  Future delete({required String byId}) async {
    try {
      final response = await Api.instance.delete(path: 'products/$byId.json');
      final indexOfDeletingProduct =
          localItems.indexWhere((element) => element.id == byId);
      final deletingProduct = localItems[indexOfDeletingProduct];
      localItems.removeWhere((element) => element.id == byId);

      if (response.statusCode >= 400) {
        localItems.insert(indexOfDeletingProduct, deletingProduct);
        throw HttpException('Error while trying delete product');
      }
      notifyListeners();
    } catch (e) {
      debugPrint('delete error: $e');
      rethrow;
    }
  }
}
