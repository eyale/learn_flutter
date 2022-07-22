import 'package:flutter/material.dart';

import '../models/place.dart';

class UserPlaces with ChangeNotifier {
  final List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }
}
