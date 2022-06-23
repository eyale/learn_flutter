import 'package:flutter/material.dart';

import '../widgets/category_list.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = '/categories';
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const CategoryList();
  }
}
