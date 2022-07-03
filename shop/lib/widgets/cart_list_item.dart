import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';

class CartListItem extends StatelessWidget {
  final CartItem cart;
  final String productId;

  const CartListItem({
    Key? key,
    required this.cart,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Cart providerCart = Provider.of<Cart>(context, listen: false);
    return Dismissible(
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        providerCart.removeCartItem(productId: productId);
      },
      key: ValueKey(cart.id),
      background: Container(
        color: Theme.of(context).colorScheme.error,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 30),
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 30,
        ),
      ),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListTile(
            leading: CircleAvatar(
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: FittedBox(
                  child: Text(
                    '\$${cart.price}',
                  ),
                ),
              ),
            ),
            title: Text(cart.title),
            subtitle: Text(
                'Total: ${(cart.price * cart.quantity).toStringAsFixed(2)}'),
            trailing: Text('${cart.quantity}x'),
          ),
        ),
      ),
    );
  }
}
