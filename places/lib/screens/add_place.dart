import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_places.dart';
import '../widgets/image_input.dart';
import '../widgets/location_input.dart';
import '../models/user_place.dart';
import '../misc/location_helper.dart';

class AddPlaceScreen extends StatefulWidget {
  static const String routeName = '/add-place';

  const AddPlaceScreen({Key? key}) : super(key: key);

  @override
  State<AddPlaceScreen> createState() => _AddPlaceScreenState();
}

class _AddPlaceScreenState extends State<AddPlaceScreen> {
  final _titleController = TextEditingController();
  PlaceLocation? _selectedLocation;

  File? _selectedImage;

  void _selectImage(File imageFile) {
    _selectedImage = imageFile;
  }

  void _selectPlace(double lat, double lng) async {
    final address = await LocationHelper.getPlaceAddress(lat: lat, lng: lng);
    debugPrint('address: $address');

    _selectedLocation = PlaceLocation(
      latitude: lat,
      longitude: lng,
      address: address,
    );
  }

  void _showErrorDialog({
    String errorText = 'Could you please pick an image and name it.',
  }) {
    showCupertinoDialog(
        context: context,
        builder: (bctx) {
          return CupertinoAlertDialog(
            title: const Text('Warning'),
            content: Text(errorText),
            actions: [
              CupertinoDialogAction(
                child: const Text('Close'),
                onPressed: () => Navigator.of(context).pop(false),
              )
            ],
          );
        });
  }

  void _savePlace() {
    if (_titleController.text.isEmpty ||
        _selectedImage == null ||
        _selectedLocation == null) {
      _showErrorDialog();
      return;
    }
    Provider.of<UserPlaces>(context, listen: false).addItem(
      name: _titleController.text,
      file: _selectedImage!,
      selectedLocation: _selectedLocation!,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add a new place'),
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    TextField(
                      controller: _titleController,
                      decoration:
                          const InputDecoration(label: Text('Image name')),
                    ),
                    const SizedBox(height: 20),
                    ImageInput(handleSelectImage: _selectImage),
                    LocationInput(onSelectPlace: _selectPlace),
                  ],
                ),
              )),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                label: const Text('Add'),
                onPressed: _savePlace,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(10),
                  shape: BeveledRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  elevation: 0,
                  primary: Theme.of(context).colorScheme.error,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
