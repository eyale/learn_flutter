import 'dart:convert' as convert;
import 'package:flutter/material.dart';

import '../models/http_exception.dart';

import '../misc/Api.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? _refreshToken;
  String? _localId;

  bool get isAuth {
    return token == null;
  }

  String? get token {
    if (_token != null) {
      return _token;
    }
    // if (_token != null &&
    //     _expiryDate != null &&
    //     _expiryDate!.isAfter(DateTime.now())) {
    //   return _token;
    // }
    return null;
  }

  Future authenticate({
    required String email,
    required String password,
    required String path,
  }) async {
    const url = 'identitytoolkit.googleapis.com';
    const params = {
      'key': 'AIzaSyDIJXVIyfJP8BvTGmF0nCtAY5-Aapbz5Es',
    };
    final encodedBody = convert.jsonEncode({
      'email': email,
      'password': password,
      'returnSecureToken': true,
    });

    try {
      final resp = await Api.instance.post(
        url: url,
        path: path,
        encodedBody: encodedBody,
        params: params,
      );
      Map<String, dynamic> decodedResp = convert.jsonDecode(resp.body);
      debugPrint('decodedResp: $decodedResp');

      if (decodedResp['error'] != null) {
        debugPrint('error: ${decodedResp['error']}');

        throw HttpException(decodedResp['error']['message']);
      }

      debugPrint('\n\ndecodedResp[idToken]: ${decodedResp['idToken']}');
      _token = decodedResp['idToken'];
      // _expiryDate = DateTime.now().add(
      //   Duration(seconds: int.parse(decodedResp['expiresIn'])),
      // );
      _localId = decodedResp['localId'];
      // _refreshToken = decodedResp['refreshToken'];
      notifyListeners();
    } catch (e) {
      debugPrint('authenticate e: $e');
      rethrow;
    }
  }

  Future login({
    required String email,
    required String password,
  }) async {
    return await authenticate(
      email: email,
      password: password,
      path: '/v1/accounts:signInWithPassword',
    );
  }

  Future signup({
    required String email,
    required String password,
  }) async {
    return await authenticate(
      email: email,
      password: password,
      path: '/v1/accounts:signUp',
    );
  }
}
