import 'dart:convert' as convert;

import 'package:flutter/material.dart';

import '../misc/Api.dart';
import '../models/http_exception.dart';
import 'product.dart';

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

  Future get({bool withFilterByUser = false}) async {
    try {
      final getParams = withFilterByUser
          ? {
              'orderBy': convert.jsonEncode('creatorId'),
              'equalTo': convert.jsonEncode(Api.instance.userId),
            }
          : null;

      final productsResp =
          await Api.instance.get(path: 'products.json', params: getParams);

      if (productsResp.body == 'null') return;

      final decodedProductsBody =
          convert.jsonDecode(productsResp.body) as Map<String, dynamic>;

      final favoritesResp = await Api.instance
          .get(path: 'usersFavorites/${Api.instance.userId}.json');

      Map<String, dynamic>? decodedFavoritesBody;
      if (favoritesResp.body != 'null') {
        decodedFavoritesBody =
            convert.jsonDecode(favoritesResp.body) as Map<String, dynamic>;
      }

      List<Product> loadedProducts = [];

      decodedProductsBody.forEach((key, value) {
        final String productId = key;
        bool isProductFavorite = false;
        isProductFavorite = favoritesResp == null
            ? false
            : decodedFavoritesBody?[productId] ?? false;

        loadedProducts.add(Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imageUrl: value['imageUrl'],
          isFavorite: isProductFavorite,
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
    final Product newProduct = product.copyWith(
      id: DateTime.now().toString(),
      creatorId: Api.instance.userId,
    );
    debugPrint('newProduct: ${newProduct.creatorId}');

    try {
      final response = await Api.instance
          .post(path: 'products.json', encodedBody: newProduct.jsonEncode());
      if (response.statusCode >= 400) {
        // print(decodedResp.body);
        // print(decodedResp.statusCode);
        // throw HttpException(decodedResp.message);
      }
      final decodedResp = convert.jsonDecode(response.body);

      final Product copiedProduct = product.copyWith(id: decodedResp['name']);
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
