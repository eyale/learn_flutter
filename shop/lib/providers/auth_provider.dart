import 'dart:convert' as convert;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
    final firKey = dotenv.env['FIR_KEY'];

    final params = {
      'key': firKey,
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
      debugPrint('\n\nAUTH\n: $decodedResp');

      if (decodedResp['error'] != null) {
        debugPrint('AUTH error: ${decodedResp['error']}');

        throw HttpException(decodedResp['error']['message']);
      }

      if (decodedResp['localId'] != null) {
        _userId = decodedResp['localId'];
        Api.instance.userId = decodedResp['localId'];
      }

      if (decodedResp['idToken'] != null) {
        Api.instance.token = decodedResp['idToken'];
        _token = decodedResp['idToken'];
      }

      // _expiryDate = DateTime.now().add(
      //   Duration(seconds: int.parse(decodedResp['expiresIn'])),
      // );
      _localId = decodedResp['localId'];
      // _refreshToken = decodedResp['refreshToken'];
      notifyListeners();
    } catch (e) {
      debugPrint('AUTH e: $e');
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
