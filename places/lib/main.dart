import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './providers/user_places.dart';
import './screens/places_list.dart';
import './screens/add_place.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: UserPlaces(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            pageTransitionsTheme: const PageTransitionsTheme(builders: {
              TargetPlatform.android: CupertinoPageTransitionsBuilder(),
            }),
            colorScheme: ColorScheme.fromSwatch().copyWith(
              primary: Colors.black,
              secondary: Colors.pink,
            ),
            fontFamily: ''),
        home: const PlacesListScreen(),
        routes: {
          AddPlaceScreen.routeName: (_) => const AddPlaceScreen(),
        },
      ),
    );
  }
}
