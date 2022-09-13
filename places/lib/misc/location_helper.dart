import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

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

  static Future<String> getPlaceAddress({
    required double lat,
    required double lng,
  }) async {
    final apiKey = getApiKey();

    final params = {
      'latlng': '$lat,$lng',
      'key': '$apiKey',
    };
    final url = Uri.https(
      'maps.googleapis.com',
      '/maps/api/geocode/json',
      params,
    );
    final response = await http.get(url);
    debugPrint('response: ${response.body}');
    debugPrint('url: $url');

    return jsonDecode(response.body)['results'][0]['formatted_address'];
  }
}
