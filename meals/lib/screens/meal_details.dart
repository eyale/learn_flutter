import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreenArguments {
  final MealModel meal;
  final Color color;

  MealDetailsScreenArguments({
    required this.meal,
    required this.color,
  });
}

class MealDetailsScreen extends StatelessWidget {
  static String routeName = '/meal-details';

  final MealModel meal;
  final Color color;
  final Function toggleFavorite;
  final Function isMealFavorite;

  const MealDetailsScreen({
    Key? key,
    required this.meal,
    required this.color,
    required this.toggleFavorite,
    required this.isMealFavorite,
  }) : super(key: key);

  Container getSectionTitle({
    required BuildContext context,
    required String title,
  }) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 0),
      width: double.infinity,
      child: Text(
        title,
        textAlign: TextAlign.left,
        style: Theme.of(context).textTheme.headlineLarge,
      ),
    );
  }

  SizedBox getContainer({
    required Widget child,
  }) {
    return SizedBox(
      height: 200,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black26, width: 0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        margin: const EdgeInsets.all(20),
        child: child,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FittedBox(child: Text(meal.title)),
        backgroundColor: color,
      ),
      body: ListView(
        children: [
          Column(children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            getSectionTitle(context: context, title: 'Ingredients:'),
            getContainer(
              child: ListView.builder(
                itemBuilder: (buildContext, index) => Card(
                  color: color,
                  elevation: 5,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      meal.ingredients[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                itemCount: meal.ingredients.length,
              ),
            ),
            getSectionTitle(context: context, title: 'Steps:'),
            getContainer(
              child: ListView.builder(
                itemBuilder: (buildContext, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    child: Text('#${index + 1}',
                        style: const TextStyle(
                            color: Colors.white,
                            shadows: [
                              Shadow(
                                offset: Offset(0, 0),
                                blurRadius: 1.0,
                                color: Color.fromARGB(255, 248, 248, 248),
                              ),
                            ],
                            fontFamily: 'Nunito',
                            fontSize: 12)),
                  ),
                  title: Text(
                    meal.steps[index],
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                ),
                itemCount: meal.steps.length,
              ),
            ),
          ])
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.error,
        elevation: 10,
        onPressed: () {
          toggleFavorite(meal.id);
        },
        child: Icon(
            isMealFavorite(meal.id) ? Icons.star : Icons.star_border_outlined),
      ),
    );
  }
}
