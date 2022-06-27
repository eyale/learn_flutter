import 'package:flutter/material.dart';

import './screens/tabs.dart';
import './screens/categories.dart';
import './screens/meals.dart';
import './screens/meal_details.dart';
import './screens/filters.dart';

import './models/meal.dart';
import 'main.dart';

Map<String, Widget Function(BuildContext)> getRoutesFrom({
  required BuildContext context,
  required Function closureToPassData,
  required List<MealModel> meals,
  required List<MealModel> favorites,
  required FilterValues filters,
  required Function toggleFavorite,
  required Function isMealFavorite,
}) {
  return {
    TabsScreen.routeName: (BuildContext buildContext) {
      return TabsScreen(
          meals: meals, favorites: favorites, toggleFavorite: toggleFavorite);
    },
    CategoriesScreen.routeName: (BuildContext buildContext) {
      return CategoriesScreen(meals: meals);
    },
    FiltersScreen.routeName: (BuildContext buildContext) {
      return FiltersScreen(
        saveFilters: closureToPassData,
        filters: filters,
      );
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
        meal: routeArguments.meal,
        color: routeArguments.color,
        toggleFavorite: toggleFavorite,
        isMealFavorite: isMealFavorite,
      );
    }
  };
}
