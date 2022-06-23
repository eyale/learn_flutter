import 'package:flutter/material.dart';

import './categories.dart';
import './favorites.dart';

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs-screen';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Tab> _tabs = [
    const Tab(
      icon: Icon(Icons.category),
      text: 'Categories',
    ),
    const Tab(
      icon: Icon(Icons.star),
      text: 'Favorites',
    ),
  ];

  final List<Widget> _tabbarViews = [
    const CategoriesScreen(),
    const FavoritesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      initialIndex: 1,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Meals'),
          bottom: TabBar(
            tabs: _tabs,
            indicatorColor: Colors.yellow,
          ),
        ),
        body: TabBarView(children: _tabbarViews),
      ),
    );
  }
}
