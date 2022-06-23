import 'package:flutter/material.dart';

import './screens/tabs.dart';
import './screens/categories.dart';
import './screens/meals.dart';
import './screens/meal_details.dart';

Map<String, Widget Function(BuildContext)> getRoutesFrom(
    {required BuildContext context}) {
  return {
    TabsScreen.routeName: (BuildContext buildContext) {
      return const TabsScreen();
    },
    CategoriesScreen.routeName: (BuildContext buildContext) {
      return const CategoriesScreen();
    },
    MealsScreen.routeName: (BuildContext buildContext) {
      final routeArguments = ModalRoute.of(buildContext)?.settings.arguments
          as MealsScreenArguments;

      return MealsScreen(
        id: routeArguments.id,
        title: routeArguments.title,
        meals: routeArguments.meals,
        color: routeArguments.color,
      );
    },
    MealDetailsScreen.routeName: (BuildContext buildContext) {
      final routeArguments = ModalRoute.of(buildContext)?.settings.arguments
          as MealDetailsScreenArguments;

      return MealDetailsScreen(
        title: routeArguments.title,
        imageUrl: routeArguments.imageUrl,
        ingredients: routeArguments.ingredients,
        steps: routeArguments.steps,
        color: routeArguments.color,
      );
    }
  };
}
