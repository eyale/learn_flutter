import 'package:http/http.dart' as http;

const String firebaseURL =
    'flutter-shop-2c434-default-rtdb.europe-west1.firebasedatabase.app';

class Api {
  Api._privateConstructor({required this.auth});
  static final Api instance = Api._privateConstructor(auth: '');

  String auth;
  Future delete({
    String url = firebaseURL,
    required String path,
  }) async {
    Map<String, dynamic>? params = {
      'auth': auth,
    };
    final uri = Uri.https(url, path, params);
    return await http.delete(uri);
  }

  Future update({
    String url = firebaseURL,
    required String path,
    required String jsonEncoded,
  }) async {
    Map<String, dynamic>? params = {
      'auth': auth,
    };

    var uri = Uri.https(url, path, params);
    return await http.patch(uri, body: jsonEncoded);
  }

  Future get({
    String url = firebaseURL,
    required String path,
  }) async {
    Map<String, dynamic>? params = {
      'auth': auth,
    };

    var uri = Uri.https(url, path, params);

    return await http.get(uri);
  }

  Future post({
    String url = firebaseURL,
    required String path,
    required String encodedBody,
    Map<String, dynamic>? params,
  }) async {
    Map<String, dynamic>? authParams = {
      'auth': auth,
    };

    if (params != null) {
      authParams.addAll(params);
    }
    var uri = Uri.https(url, path, params);

    return await http.post(uri, body: encodedBody);
  }
}
