import 'package:flutter/material.dart';

import '../widgets/category_list.dart';

import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  static String routeName = '/categories';

  final List<MealModel> meals;

  const CategoriesScreen({
    Key? key,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CategoryList(meals: meals);
  }
}
