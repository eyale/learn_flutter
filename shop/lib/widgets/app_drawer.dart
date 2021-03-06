import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../misc/CustomRoute.dart';
import '../providers/auth_provider.dart';
import '../screens/orders.dart';
import '../screens/user_products.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    List<Widget> _getDrawerMenu() {
      return [
        Column(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/drawer_bg.jpeg'),
                  opacity: 0.4,
                  fit: BoxFit.cover,
                ),
              ),
              child: Center(
                child: Text(
                  'Shop',
                  style: TextStyle(
                      fontSize: 38,
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                      shadows: const [
                        Shadow(color: Colors.white, offset: Offset(2, 2))
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
                  // Navigator.of(context)
                  //     .pushReplacementNamed(OrdersScreen.routeName);

                  // Custom Route example
                  Navigator.of(context).pushReplacement(
                      CustomRoute(builder: (ctx) => OrdersScreen()));
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
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
          child: ListTile(
            leading: const Icon(CupertinoIcons.arrow_right_circle_fill),
            title: const Text('Logout'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout().then(
                  (value) => Navigator.of(context).pushReplacementNamed('/'));
            },
          ),
        )
      ];
    }

    return Drawer(
      child: isPortrait
          ? Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: _getDrawerMenu(),
            )
          : ListView(
              children: _getDrawerMenu(),
            ),
    );
  }
}
