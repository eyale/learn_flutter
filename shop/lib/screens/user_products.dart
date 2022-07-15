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
  Future _getProducts(BuildContext context) async {
    await Provider.of<Products>(context, listen: false)
        .get(withFilterByUser: true);
  }

  @override
  Widget build(BuildContext context) {
    // final productsProvider = Provider.of<Products>(context, listen: false);

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
        body: FutureBuilder(
            future: _getProducts(context),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (snapshot.error != null) {
                debugPrint('snapshot.error: ${snapshot.error}');
                return const Center(
                  child: Text('Ooops... something went wrong 🤷'),
                );
              }
              return RefreshIndicator(
                onRefresh: () => _getProducts(context),
                child: Consumer<Products>(
                  builder: (context, products, child) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
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
                    );
                  },
                ),
              );
            }));
  }
}
