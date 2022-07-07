import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/edit_products.dart';

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
                    onPressed: () {},
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
