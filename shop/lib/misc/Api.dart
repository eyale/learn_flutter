import 'package:http/http.dart' as http;

const String firebaseURL =
    'flutter-shop-2c434-default-rtdb.europe-west1.firebasedatabase.app';

class Api {
  Api._privateConstructor();
  static final Api instance = Api._privateConstructor();

  Future delete({
    String url = firebaseURL,
    required String path,
  }) async {
    final uri = Uri.https(url, path);
    return await http.delete(uri);
  }

  Future edit({
    String url = firebaseURL,
    required String path,
    required String jsonEncoded,
  }) async {
    var uri = Uri.https(url, path);
    return await http.patch(uri, body: jsonEncoded);
  }

  Future get({
    String url = firebaseURL,
    required String path,
  }) async {
    var uri = Uri.https(url, path);

    return await http.get(uri);
  }

  Future post({
    String url = firebaseURL,
    required String path,
    required String jsonEncoded,
  }) async {
    var uri = Uri.https(url, path);

    return await http.post(uri, body: jsonEncoded);
  }
}
