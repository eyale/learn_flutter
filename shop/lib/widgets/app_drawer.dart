import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../screens/orders.dart';
import '../screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/drawer_bg.jpeg'),
                fit: BoxFit.cover,
              ),
            ),
            child: Center(
              child: Text(
                'Shop',
                style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                          color: Theme.of(context).colorScheme.primary,
                          offset: Offset(2, 2))
                    ]),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: ListTile(
              leading: const Icon(CupertinoIcons.bag_badge_plus),
              title: const Text('Shop'),
              onTap: () {
                Navigator.of(context).pushReplacementNamed('/');
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: ListTile(
              leading: const Icon(CupertinoIcons.cart),
              title: const Text('Orders'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(OrdersScreen.routeName);
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: ListTile(
              leading: const Icon(CupertinoIcons.pencil),
              title: const Text('Manage products'),
              onTap: () {
                Navigator.of(context)
                    .pushReplacementNamed(UserProductsScreen.routeName);
              },
            ),
          ),
        ],
      ),
    );
  }
}
