import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class MealsScreenArguments {
  final String id;
  final String title;
  final List<MealModel> meals;
  final Color color;

  MealsScreenArguments({
    required this.id,
    required this.title,
    required this.meals,
    required this.color,
  });
}

class MealsScreen extends StatelessWidget {
  static String routeName = '/meals';

  final String id;
  final String title;
  final List<MealModel> meals;
  final Color color;

  const MealsScreen({
    Key? key,
    required this.id,
    required this.title,
    required this.meals,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              title: meals[index].title,
              imageUrl: meals[index].imageUrl,
              duration: meals[index].duration,
              complexity: meals[index].complexity,
              affordability: meals[index].affordability,
              ingredients: meals[index].ingredients,
              steps: meals[index].steps,
              color: color,
            );
          },
          itemCount: meals.length
          ),
      ),
    );
  }
}
