import 'package:flutter/material.dart';

import './screens/categories.dart';
import './screens/tabs.dart';
import './routes.dart';

import './models/meal.dart';
import './dummy_data.dart';

void main() {
  runApp(const MyApp());
}

class FilterValues {
  final bool glutenFree;
  final bool vegeterian;
  final bool vegan;
  final bool lactoseFree;

  FilterValues({
    required this.glutenFree,
    required this.vegeterian,
    required this.vegan,
    required this.lactoseFree,
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FilterValues filters = FilterValues(
    glutenFree: false,
    lactoseFree: false,
    vegan: false,
    vegeterian: false,
  );

  List<MealModel> _availableMeals = DUMMY_MEALS;

  void _setFilters(FilterValues filtersData) {
    setState(() {
      filters = filtersData;

      _availableMeals = DUMMY_MEALS.where((element) {
        if (filters.glutenFree && !element.isGlutenFree) return false;
        if (filters.lactoseFree && !element.isLactoseFree) return false;
        if (filters.vegan && !element.isVegan) return false;
        if (filters.vegeterian && !element.isVegetarian) return false;
        return true;
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Nunito',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: const TextStyle(
                  fontSize: 18,
                  color: Color.fromARGB(240, 55, 55, 7),
                ),
                bodyText2: const TextStyle(
                  fontSize: 14,
                  color: Colors.blueGrey,
                ),
                headlineLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                ),
              ),
          canvasColor: const Color.fromARGB(248, 238, 235, 248),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(248, 173, 162, 201),
            secondary: Colors.indigo,
          )),
      initialRoute: TabsScreen.routeName,
      routes: getRoutesFrom(
        context: context,
        closureToPassData: _setFilters,
        meals: _availableMeals,
        filters: filters,
      ),
      // onGenerateRoute: (data) {
      //   print('onGenerateRoute data: $data');
      //   return MaterialPageRoute(builder: (context) => const CategoriesScreen());
      // },
      onUnknownRoute: (data) {
        print('onUnknownRoute data: $data');
        return MaterialPageRoute(
            builder: (context) => CategoriesScreen(
                  meals: _availableMeals,
                ));
      },
    );
  }
}
