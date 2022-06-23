import 'package:flutter/material.dart';

import './screens/categories.dart';
import './routes.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
          fontFamily: 'Nunito',
          textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1:
                    const TextStyle(color: Color.fromARGB(240, 55, 55, 7)),
                bodyText2:
                    const TextStyle(color: Color.fromARGB(230, 55, 55, 7)),
                headlineLarge: const TextStyle(
                  fontFamily: 'RobotoCondensed',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
          canvasColor: const Color.fromARGB(248, 238, 235, 248),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            primary: const Color.fromARGB(248, 173, 162, 201),
            secondary: Colors.indigo,
          )),
      initialRoute: CategoriesScreen.routeName,
      routes: getRoutesFrom(context: context),
      // onGenerateRoute: (data) {
      //   print('onGenerateRoute data: $data');
      //   return MaterialPageRoute(builder: (context) => const CategoriesScreen());
      // },
      onUnknownRoute: (data) {
        print('onUnknownRoute data: $data');
        return MaterialPageRoute(builder: (context) => const CategoriesScreen());
      },
    );
  }
}
