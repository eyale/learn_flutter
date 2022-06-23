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

class MealsScreen extends StatefulWidget {
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
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  void removeMealItem({required String byId}) {
    print(byId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: widget.color,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemBuilder: (context, index) {
              return MealItem(
                meal: widget.meals[index],
                color: widget.color,
                removeMealItem: (id) =>
                    removeMealItem(byId: id),
              );
            },
            itemCount: widget.meals.length),
      ),
    );
  }
}
