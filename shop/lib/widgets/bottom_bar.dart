import 'package:flutter/material.dart';

import '../screens/maps.dart';
import '../screens/products_overview.dart';
import './webview.dart';

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: _title,
      home: BottomBar(),
    );
  }
}

class BottomBar extends StatefulWidget {
  static String routeName = '/bottomBar';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(
    fontSize: 30,
    fontWeight: FontWeight.bold,
  );

  static const List<Widget> _widgetOptions = <Widget>[
    ProductsOverviewScreen(),
    WebViewScreen(),
    InteractiveTestPage(),
    Text(
      'Index 3: Settings',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.white70,
        selectedItemColor: Colors.white,
        selectedFontSize: 16,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            activeIcon: const Icon(Icons.home_filled),
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Theme.of(context).colorScheme.primary,
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(Icons.web_outlined),
            icon: Icon(Icons.web_asset),
            label: 'WebView',
            backgroundColor: Colors.teal,
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(Icons.map_outlined),
            icon: Icon(Icons.map),
            label: 'Map',
            backgroundColor: Colors.brown,
          ),
          const BottomNavigationBarItem(
            activeIcon: Icon(Icons.settings_outlined),
            icon: Icon(Icons.settings),
            label: 'Settings',
            backgroundColor: Colors.indigo,
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
