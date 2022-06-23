import 'package:flutter/material.dart';

import '../screens/tabs.dart';
import '../screens/filters.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  Container getTileItem({
    required String title,
    required IconData icon,
    required Function onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: Colors.blueGrey,
        ),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.blueGrey,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () => onTap(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          color: Colors.amberAccent,
          child: Text(
            'Meals \nTry not. Cook or not cook,\nThere is no try!',
            style: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontFamily: 'RobotoCondensed',
                fontWeight: FontWeight.bold,
                fontSize: 30),
          ),
        ),
        getTileItem(
            icon: Icons.restaurant,
            title: 'Meals',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(TabsScreen.routeName);
            }),
        getTileItem(
            icon: Icons.settings,
            title: 'Filters',
            onTap: () {
              Navigator.of(context).pushReplacementNamed(FiltersScreen.routeName);
            })
      ]),
    );
  }
}
