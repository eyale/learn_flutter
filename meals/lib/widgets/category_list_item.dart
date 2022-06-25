import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

import '../screens/meals.dart';

import '../models/meal.dart';

class CategoryListItem extends StatelessWidget {
  final String id;
  final String title;
  final Color color;
  final List<MealModel> meals;

  const CategoryListItem({
    Key? key,
    required this.meals,
    required this.id,
    required this.title,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final BorderRadius br = BorderRadius.circular(15);

    void onTapCategory({required BuildContext widgetContext}) {
      final List<MealModel> categoryMeals = meals.where((element) {
        return element.categories.contains(id);
      }).toList();

      Navigator.of(widgetContext).pushNamed(
        MealsScreen.routeName,
        arguments: MealsScreenArguments(
          id: id,
          title: title,
          meals: categoryMeals,
          color: color,
        ),
      );
    }

    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      onTap: () => onTapCategory(widgetContext: context),
      borderRadius: br,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color,
              color.withOpacity(0.5),
            ],
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
          ),
          borderRadius: br,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headlineLarge,
            )
          ],
        ),
      ),
    );
  }
}
