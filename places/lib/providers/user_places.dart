import 'dart:io';

import 'package:flutter/material.dart';

import '../models/user_place.dart';
import '../misc/db_helper.dart';

class UserPlaces with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  void addItem({required String name, required File file}) {
    PlaceModel itemToAdd = PlaceModel(
      id: DateTime.now().toString(),
      title: name,
      image: file,
      location: null,
    );

    _items.add(itemToAdd);
    notifyListeners();

    Map<String, String> dbData = {
      'id': itemToAdd.id,
      'title': itemToAdd.title,
      'image': itemToAdd.image.path,
    };

    DBHelper.insert(tableName: DBTables.userPlaces.name, data: dbData);
  }

  Future<void> getAndSetUserPlaces() async {
    final dbData = await DBHelper.getData(
      tableName: DBTables.userPlaces.name,
    );

    _items = dbData
        .map((e) => PlaceModel(
              id: e['id'].toString(),
              title: e['title'].toString(),
              image: File(e['image'].toString()),
              location: null,
            ))
        .toList();

    notifyListeners();
  }
}
