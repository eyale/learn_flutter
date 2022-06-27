import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class FavoritesScreen extends StatelessWidget {
  final List<MealModel> favorites;
  final Function toggleFavorite;

  const FavoritesScreen({
    Key? key,
    required this.favorites,
    required this.toggleFavorite,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (favorites.isEmpty) {
      return const Center(
        child: Text('You have no Favorites - start adding some!'),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return MealItem(
              meal: favorites[index],
              color: Colors.indigo,
            );
          },
          itemCount: favorites.length,
        ),
      );
    }
  }
}
