import 'package:flutter/material.dart';

class MealDetailsScreenArguments {
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final Color color;

  MealDetailsScreenArguments({
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.color,
  });
}

class MealDetailsScreen extends StatelessWidget {
  static String routeName = '/meal-details';
  final String title;
  final String imageUrl;
  final List<String> ingredients;
  final List<String> steps;
  final Color color;

  const MealDetailsScreen({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.ingredients,
    required this.steps,
    required this.color,
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
        title: FittedBox(child: Text(title)),
        backgroundColor: color,
      ),
      body: ListView(
        children: [
          Column(
          children: [
            SizedBox(
              height: 250,
              width: double.infinity,
              child: Image.network(
                imageUrl,
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
                      ingredients[index],
                      style: const TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                itemCount: ingredients.length,
              ),
            ),
            getSectionTitle(context: context, title: 'Steps:'),
            getContainer(
              child: ListView.builder(
                itemBuilder: (buildContext, index) => ListTile(
                  leading: CircleAvatar(
                    backgroundColor: color,
                    child: Text('#${index+1}',
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
                      fontSize: 12
                    )
                  ),),
                  title: Text(
                      steps[index],
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                ),
                itemCount: steps.length,
              ),
            ),
          ],
        )
        ],
      ),
    );
  }
}
