import 'package:flutter/material.dart';

class LocationInput extends StatefulWidget {
  const LocationInput({Key? key}) : super(key: key);

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String? _previewImageUrl;

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
              onPressed: () {},
              label: Text(
                'Current location',
                style: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
              style: ElevatedButton.styleFrom(
                  primary: Theme.of(context).colorScheme.secondary),
            ),
            ElevatedButton.icon(
              icon: const Icon(Icons.map),
              onPressed: () {},
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
