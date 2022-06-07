import 'package:flutter/material.dart';

import 'screens/home.dart';

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
      title: 'Expanse planner',
      theme: ThemeData(
        primarySwatch: Colors.lime,
        textTheme: const TextTheme(
          subtitle1: TextStyle(color: Colors.cyan),
          headline1: TextStyle(color: Colors.deepOrange),
          headline2: TextStyle(color: Colors.deepPurple),
          subtitle2: TextStyle(color: Colors.greenAccent),
          bodyText2: TextStyle(color: Colors.teal),
          bodyText1: TextStyle(color: Colors.indigo),
        ),
        appBarTheme: const AppBarTheme(foregroundColor: Colors.brown),
        iconTheme: const IconThemeData(color: Colors.amber),
        primaryIconTheme: const IconThemeData(color: Colors.lightGreen),
        floatingActionButtonTheme: const FloatingActionButtonThemeData(
          backgroundColor: Colors.red,
          foregroundColor: Colors.white,
        ),
      ),
      home: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: MyHomePage(),
      ),
    );
  }
}
