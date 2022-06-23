import 'package:flutter/material.dart';

import '../widgets/category_list.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = '/';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily meals'),
      ),
      body: const CategoryList(),
    );
  }
}
