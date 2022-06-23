import 'package:flutter/material.dart';

import './categories.dart';
import './favorites.dart';

import '../widgets/custom_drawer.dart';

class TabBarData {
  final String title;
  final Widget tab;
  final Color color;

  const TabBarData({
    required this.title,
    required this.tab,
    required this.color,
  });
}

class TabsScreen extends StatefulWidget {
  static String routeName = '/tabs-screen';

  const TabsScreen({Key? key}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<BottomNavigationBarItem> _bottomTabBarItem = [
    const BottomNavigationBarItem(
        icon: Icon(Icons.category), label: 'Category'),
    const BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites')
  ];

  int _selectedTab = 0;

  void _onBottomBarTap(int nextTab) {
    setState(() => _selectedTab = nextTab);
  }

  @override
  Widget build(BuildContext context) {
  final List<TabBarData> tabbarViews = [
      TabBarData(
      title: 'categories',
      tab: const CategoriesScreen(),
      color: Theme.of(context).colorScheme.primary,
    ),
     TabBarData(
      title: 'favorites',
      tab: const FavoritesScreen(),
      color: Theme.of(context).colorScheme.secondary
      ),
  ];

    return Scaffold(
      appBar: AppBar(
        title: Text(tabbarViews[_selectedTab].title.toUpperCase()),
        backgroundColor: tabbarViews[_selectedTab].color,
      ),
      drawer: const CustomDrawer(),
      body: tabbarViews[_selectedTab].tab,
      bottomNavigationBar: BottomNavigationBar(
        items: _bottomTabBarItem,
        currentIndex: _selectedTab,
        onTap: _onBottomBarTap,
        backgroundColor: tabbarViews[_selectedTab].color,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black45,
      ),
    );
  }
}
