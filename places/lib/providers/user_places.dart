import 'dart:io';

import 'package:flutter/material.dart';

import '../models/user_place.dart';
import '../misc/db_helper.dart';
import '../misc/location_helper.dart';

class UserPlaces with ChangeNotifier {
  List<PlaceModel> _items = [];

  List<PlaceModel> get items {
    return [..._items];
  }

  int get count {
    return _items.length;
  }

  Future<void> addItem({
    required String name,
    required File file,
    required PlaceLocation selectedLocation,
  }) async {
    final address = await LocationHelper.getPlaceAddress(
      lat: selectedLocation.latitude,
      lng: selectedLocation.longitude,
    );

    final updatedLocation = PlaceLocation(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
      address: address,
    );

    PlaceModel itemToAdd = PlaceModel(
      id: DateTime.now().toString(),
      title: name,
      image: file,
      location: selectedLocation,
    );

    _items.add(itemToAdd);
    notifyListeners();

    Map<String, String> dbData = {
      'id': itemToAdd.id,
      'title': itemToAdd.title,
      'image': itemToAdd.image.path,
      'loc_lat': itemToAdd.location.latitude.toString(),
      'loc_lng': itemToAdd.location.longitude.toString(),
      'address': itemToAdd.location.address,
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
              location: PlaceLocation(
                latitude: double.parse(e['loc_lat'].toString()),
                longitude: double.parse(e['loc_lng'].toString()),
                address: e['address'].toString(),
              ),
            ))
        .toList();

    notifyListeners();
  }
}
