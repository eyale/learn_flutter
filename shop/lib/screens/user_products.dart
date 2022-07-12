import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products_provider.dart';
import '../screens/edit_products.dart';
import '../widgets/app_drawer.dart';
import '../widgets/user_product_item.dart';

class UserProductsScreen extends StatefulWidget {
  static String routeName = '/user_products';
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  State<UserProductsScreen> createState() => _UserProductsScreenState();
}

class _UserProductsScreenState extends State<UserProductsScreen> {
  @override
  Widget build(BuildContext context) {
    bool isLoading = false;
    final products = Provider.of<Products>(context);

    Future getProducts() {
      setState(() {
        isLoading = !isLoading;
      });
      return products.get().then((_) {
        setState(() {
          isLoading = !isLoading;
        });
      });
    }

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('User products'),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.plus),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductsScreen.routeName);
            },
          )
        ],
      ),
      body: RefreshIndicator(
        onRefresh: getProducts,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: ListView.builder(
            itemCount: products.count,
            itemBuilder: (context, index) {
              return UserProductItem(
                id: products.items[index].id,
                title: products.items[index].title,
                imageUrl: products.items[index].imageUrl,
              );
            },
          ),
        ),
      ),
    );
  }
}
