import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './add_place.dart';
import '../providers/user_places.dart';
import './place_details.dart';

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
      body: FutureBuilder(
        future: Provider.of<UserPlaces>(context, listen: false)
            .getAndSetUserPlaces(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).colorScheme.primary,
              ),
            );
          }
          return SafeArea(
            child: Consumer<UserPlaces>(
              child: Center(
                child: SizedBox(
                  height: 100,
                  child: Column(
                    children: [
                      Icon(
                        Icons.warning_amber,
                        size: 54,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        'There is no places yet',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                            color: Colors.grey),
                      )
                    ],
                  ),
                ),
              ),
              builder: (context, userPlacesProviderData, child) {
                if (userPlacesProviderData.items.isEmpty) {
                  return child!;
                } else {
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                    child: ListView.builder(
                      itemBuilder: (ctx, i) {
                        void _handleTapListItem() {
                          //navigate to DetailsScreen;
                          Navigator.of(context).pushNamed(
                              PlaceDetails.routeName,
                              arguments: userPlacesProviderData.items[i].id);
                        }

                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5),
                          child: ListTile(
                            tileColor: Colors.teal.shade100,
                            leading: CircleAvatar(
                              backgroundImage: FileImage(
                                userPlacesProviderData.items[i].image,
                              ),
                            ),
                            title: Text(userPlacesProviderData.items[i].title),
                            subtitle: Text(userPlacesProviderData
                                .items[i].location.address),
                            onTap: _handleTapListItem,
                          ),
                        );
                      },
                      itemCount: userPlacesProviderData.count,
                    ),
                  );
                }
              },
            ),
          );
        },
      ),
    );
  }
}
