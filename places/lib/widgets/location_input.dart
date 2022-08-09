import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/cupertino.dart';

import '../misc/location_helper.dart';
import '../screens/map.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;
  Location location = Location();

  void _showErrorDialog({
    String errorText = 'Could you please pick an image and name it.',
    Function? action,
  }) {
    showCupertinoDialog(
        context: context,
        builder: (bctx) {
          return CupertinoAlertDialog(
            title: const Text('Warning'),
            content: Text(errorText),
            actions: [
              CupertinoDialogAction(
                child: const Text('Ok'),
                onPressed: () {
                  Navigator.of(context).pop(false);
                  if (action != null) action();
                },
              )
            ],
          );
        });
  }

  void _generateLocationPreview(
      {required double latitude, required double longitude}) {
    final locationPreviewUrl = LocationHelper.getLocationPreviewUrl(
      latitude: latitude,
      longitude: longitude,
    );

    setState(() {
      _previewImageUrl = locationPreviewUrl;
    });
  }

  void _getCurrentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    debugPrint('permissionGranted: $permissionGranted');
    if (permissionGranted != PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      debugPrint('2permissionGranted: $permissionGranted');
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }
    // else {
    //   _showErrorDialog(
    //     errorText:
    //         'You have denied location requests. In order to enable it go to the app Settings',
    //     action: AppSettings.openAppSettings,
    //   );
    // }

    locationData = await location.getLocation();

    _generateLocationPreview(
      latitude: locationData.latitude!,
      longitude: locationData.longitude!,
    );
  }

  Future<void> _handleTapSelectOnMap() async {
    LatLng selectedLocation = await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (ctx) => const MapScreen(
          isSelecting: true,
        ),
      ),
    );

    if (selectedLocation == null) return;

    _generateLocationPreview(
      latitude: selectedLocation.latitude,
      longitude: selectedLocation.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Container(
            height: 200,
            width: double.infinity,
            decoration: BoxDecoration(
                border: Border.all(
              width: 1,
              color: Colors.grey.shade300,
            )),
            alignment: Alignment.center,
            child: _previewImageUrl == null
                ? const Text('There is no image')
                : Image.network(
                    _previewImageUrl!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              icon: const Icon(Icons.location_on),
              onPressed: _getCurrentLocation,
              label: Text(
                'Current location',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              onPressed: _handleTapSelectOnMap,
              label: Text(
                'Select on map',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary),
            ),
          ],
        )
      ],
    );
  }
}
