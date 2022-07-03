import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/product.dart';
import '../screens/product_details.dart';

class ProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<Product>(
            builder: (context, item, child) => IconButton(
              icon: Icon(item.isFavorite
                  ? CupertinoIcons.heart_fill
                  : CupertinoIcons.heart),
              onPressed: item.toggleIsFavorite,
              color: item.isFavorite
                  ? Theme.of(context).colorScheme.secondary
                  : Colors.white,
            ),
          ),
          trailing: IconButton(
            icon: Icon(cart.items.containsKey(product.id)
                ? CupertinoIcons.cart_fill
                : CupertinoIcons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
            onPressed: () {
              cart.addCartItem(product: product);
              // cart.toggleCartItem(product: product);
            },
          ),
          title: FittedBox(
            child: Text(
              product.title,
            ),
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
          ),
          onTap: () {
            Navigator.of(context).pushNamed(
              ProductDetailsScreen.routeName,
              arguments: product.id,
            );
          },
        ),
      ),
    );
  }
}
