import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../screens/edit_products.dart';

import '../providers/products_provider.dart';

class UserProductItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;

  const UserProductItem({
    Key? key,
    required this.id,
    required this.title,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    return Column(
      children: [
        ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(imageUrl),
          ),
          title: Text(title),
          trailing: SizedBox(
              width: 110,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () async {
                      try {
                        final resp = await productsProvider.delete(byId: id);
                      } catch (e) {
                        debugPrint('e: $e');
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          // backgroundColor: Colors.blueGrey,
                          content: Text(
                            e.toString(),
                            style: const TextStyle(fontSize: 16),
                          ),
                        ));
                        rethrow;
                      }
                    },
                    icon: Icon(
                      CupertinoIcons.delete,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pushNamed(
                          EditProductsScreen.routeName,
                          arguments: id);
                    },
                    icon: const Icon(
                      CupertinoIcons.chevron_forward,
                      color: Colors.grey,
                    ),
                  ),
                ],
              )),
        ),
        const Divider(),
      ],
    );
  }
}