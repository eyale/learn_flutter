import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_places.dart';
import './map.dart';

class PlaceDetails extends StatelessWidget {
  static const routeName = "/place-detail";

  const PlaceDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final id = ModalRoute.of(context)?.settings.arguments as String;
    final place =
        Provider.of<UserPlaces>(context, listen: false).getItemById(id);
    void _onOpenMap() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => MapScreen(
            initialLocation: place.location,
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(place.title)),
      body: Column(children: [
        SizedBox(
          height: 250,
          width: double.infinity,
          child: Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: Text(
            place.location.address,
            style: const TextStyle(
              fontSize: 20,
              color: Colors.green,
            ),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _onOpenMap,
          child: const Text('View on Map'),
        )
      ]),
    );
  }
}
