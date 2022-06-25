import 'package:flutter/material.dart';

import './category_list_item.dart';

import '../dummy_data.dart';

import '../models/meal.dart';

class CategoryList extends StatelessWidget {
  final List<MealModel> meals;

  const CategoryList({
    Key? key,
    required this.meals,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView(
        padding: const EdgeInsets.all(20.0),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: DUMMY_CATEGORIES
            .map(
              (item) => CategoryListItem(
                meals: meals,
                key: ValueKey(item.id),
                id: item.id,
                color: item.color,
                title: item.title,
              ),
            )
            .toList());
  }
}
