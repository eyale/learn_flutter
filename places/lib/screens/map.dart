import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/user_place.dart';

class MapScreen extends StatefulWidget {
  final PlaceLocation? initialLocation;
  final bool isSelecting;

  const MapScreen({
    Key? key,
    this.initialLocation = const PlaceLocation(
      latitude: 37.422,
      longitude: -122.084,
      address: '',
    ),
    this.isSelecting = false,
  }) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  LatLng? _selectedLocation;

  void _handleTapMap(LatLng position) {
    debugPrint('position: $position');
    setState(() {
      _selectedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          if (_selectedLocation != null)
            IconButton(
              icon: const Icon(Icons.save),
              onPressed: () {
                Navigator.of(context).pop(_selectedLocation);
              },
            )
        ],
      ),
      body: GoogleMap(
        onTap: widget.isSelecting ? _handleTapMap : null,
        markers: (_selectedLocation == null && widget.isSelecting)
            ? {}
            : {
                Marker(
                  markerId: MarkerId(DateTime.now().toString()),
                  position: _selectedLocation ??
                      LatLng(
                        widget.initialLocation!.latitude,
                        widget.initialLocation!.longitude,
                      ),
                ),
              },
        initialCameraPosition: CameraPosition(
            zoom: 16,
            target: LatLng(
              widget.initialLocation!.latitude,
              widget.initialLocation!.longitude,
            )),
      ),
    );
  }
}
