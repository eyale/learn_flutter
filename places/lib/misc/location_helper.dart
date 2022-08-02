import 'package:flutter_dotenv/flutter_dotenv.dart';

class LocationHelper {
  static String? getApiKey() {
    return dotenv.env['GOOGLE_API_KEY'];
  }

  static String getLocationPreviewUrl({
    required double latitude,
    required double longitude,
  }) {
    final apiKey = getApiKey();

    return 'https://maps.googleapis.com/maps/api/staticmap?center=$latitude,$longitude&zoom=16&size=600x300&maptype=roadmap&markers=color:red%7Alabel:A%7C$latitude,$longitude&key=$apiKey';
  }
}
