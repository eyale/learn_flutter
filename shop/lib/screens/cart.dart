import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart.dart';
import '../providers/order.dart';
import '../widgets/app_drawer.dart';
import '../widgets/cart_list_item.dart';

class CartScreen extends StatelessWidget {
  static String routeName = '/cart_screen';

  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final order = Provider.of<Order>(context, listen: false);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Card(
                elevation: 5,
                margin: const EdgeInsets.symmetric(vertical: 10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total: ',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const Spacer(),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Chip(
                          backgroundColor: Theme.of(context)
                              .colorScheme
                              .primary
                              .withAlpha(220),
                          label: SizedBox(
                            child: Text(
                              '\$${cart.totalAmount.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      OrderButton(cart: cart, order: order),
                    ],
                  ),
                ),
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: cart.items.length,
                      itemBuilder: (_, index) {
                        return CartListItem(
                          cart: cart.items.values.toList()[index],
                          productId: cart.items.keys.toList()[index],
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.cart,
    required this.order,
  }) : super(key: key);

  final Cart cart;
  final Order order;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  bool _isLoading = false;

  void toggleIsLoading() {
    return setState(() {
      _isLoading = !_isLoading;
    });
  }

  Future<dynamic> showCupertinoDialog() {
    return showDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: const Text('Warning!'),
            content: const Text('There is empty cart.'),
            actions: [
              CupertinoDialogAction(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Ok'))
            ],
          );
        });
  }

  void handleTapOrderNow() async {
    if (widget.cart.items.isEmpty && !_isLoading) {
      showCupertinoDialog();
    } else {
      toggleIsLoading();
      await widget.order.add(
          products: widget.cart.items.values.toList(),
          totalAmount: widget.cart.totalAmount);
      toggleIsLoading();
      widget.cart.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
        backgroundColor:
            MaterialStateProperty.all(Theme.of(context).colorScheme.secondary),
      ),
      onPressed: handleTapOrderNow,
      child: _isLoading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(
                color: Colors.white,
              ))
          : const Text('Order now'),
    );
  }
}
