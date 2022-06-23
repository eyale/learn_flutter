import 'package:flutter/material.dart';

import '../widgets/custom_drawer.dart';

class FiltersScreen extends StatelessWidget {
  static String routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(title: const Text('Filters')),
      body: Container(
        child: const Text('FiltersScreen'),
      ),
    );
  }
}
