import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'screens/home.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  // ]);
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
        fontFamily: 'DMSans',
        textTheme: ThemeData.light().textTheme.copyWith(
              // Variant 1 - uncomment and comment Variant 2
              // bodyMedium: const TextStyle(color: Colors.cyan),
              // bodyLarge: const TextStyle(color: Colors.red),
              // bodySmall: const TextStyle(color: Colors.deepPurple),

              // Variant 2 - uncomment and comment Variant 1
              subtitle1: const TextStyle(color: Colors.cyan),
              headline1: const TextStyle(color: Colors.deepOrange),
              // headline3: ,
              // headline4: ,
              // headline5: ,
              // headline6: ,
              // headlineLarge: ,
              // headlineMedium: ,
              // headlineSmall: ,
              subtitle2: const TextStyle(color: Colors.greenAccent),
              bodyText2: const TextStyle(color: Colors.teal),
              bodyText1: const TextStyle(color: Colors.indigo),
            ),
        appBarTheme: const AppBarTheme(
            foregroundColor: Colors.redAccent,
            backgroundColor: Colors.black,
            titleTextStyle: TextStyle(
              fontFamily: 'DMSans',
              // fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
              fontSize: 20,
              color: Colors.orange,
            )),
        iconTheme: const IconThemeData(color: Colors.amber),
        primaryIconTheme: const IconThemeData(color: Colors.lightGreen),
        errorColor: Colors.pinkAccent,
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
