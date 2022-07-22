import 'package:flutter/material.dart';

import './add_place.dart';

class PlacesListScreen extends StatelessWidget {
  static const String routeName = '/places-list';
  const PlacesListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void _handleTapAddPlace() {
      Navigator.of(context).pushNamed(AddPlaceScreen.routeName);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PLACESLIST'),
        actions: [
          IconButton(
            onPressed: _handleTapAddPlace,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: const Text('placeslist'),
    );
  }
}
