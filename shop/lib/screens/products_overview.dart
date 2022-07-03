import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './cart.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum PopupFilterOptions {
  all,
  favorites,
}

class ProductsOverviewScreen extends StatefulWidget {
  ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _isShowFavorites = false;

  void setShowFavorites({required bool isVisible}) {
    setState(() {
      _isShowFavorites = isVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Shop'),
        leading: Consumer<Cart>(
          builder: (context, item, childWidget) => Badge(
              value: item.count.toString(),
              color: Colors.pinkAccent,
              child: IconButton(
                icon: const Icon(CupertinoIcons.shopping_cart),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              )),
        ),
        actions: [
          PopupMenuButton(
            onSelected: (PopupFilterOptions value) {
              setShowFavorites(
                isVisible: value == PopupFilterOptions.favorites,
              );
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: PopupFilterOptions.all,
                child: Text('Show all'),
              ),
              const PopupMenuItem(
                value: PopupFilterOptions.favorites,
                child: Text('Show favorites'),
              )
            ],
            icon: const Icon(Icons.more_vert_outlined),
          ),
        ],
      ),
      body: ProductsGrid(
        isShowFavorites: _isShowFavorites,
      ),
    );
  }
}
