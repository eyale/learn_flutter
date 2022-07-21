import 'dart:async';
import 'dart:convert' as convert;

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../misc/Api.dart';
import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? _userId;
  String? _refreshToken;
  String? _localId;

  Timer? _timer;

  bool get isAuth {
    return token != null;
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
      debugPrint('AUTH\n: $decodedResp');

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

      if (decodedResp['expiresIn'] != null) {
        _expiryDate = DateTime.now().add(
          Duration(seconds: int.parse(decodedResp['expiresIn'])),
        );
      }

      _localId = decodedResp['localId'];

      setSharedPrefs();
      autoLogout();
      notifyListeners();
    } catch (e) {
      debugPrint('AUTH e: $e');
      rethrow;
    }
  }

  Future<bool> autoLogin() async {
    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    debugPrint('prefs.containsKey(UserData)');
    debugPrint(prefs.containsKey('UserData').toString());

    if (!prefs.containsKey('UserData')) return false;
    final userDataString = prefs.getString('UserData');
    debugPrint('userDataString');
    debugPrint(userDataString);

    final extractedUserData =
        convert.jsonDecode(userDataString!) as Map<String, dynamic>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    debugPrint('expiryDate');
    debugPrint(expiryDate.toString());
    debugPrint(expiryDate.isBefore(DateTime.now()).toString());

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }

    _token = extractedUserData['token'];
    Api.instance.token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    Api.instance.userId = extractedUserData['userId'];
    _expiryDate = expiryDate;

    notifyListeners();
    autoLogout();
    return true;
  }

  void setSharedPrefs() async {
    final expDate = _expiryDate ?? DateTime.now();
    final encodedValuesSP = convert.jsonEncode({
      'token': token,
      'userId': _userId,
      'expiryDate': expDate.toIso8601String(),
    });

    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.setString('UserData', encodedValuesSP);
  }

  void autoLogout() {
    if (_expiryDate == null) return;
    if (_timer != null) {
      _timer?.cancel();
    }
    final expirationTokenTime =
        _expiryDate!.difference(DateTime.now()).inSeconds;

    _timer = Timer.periodic(Duration(seconds: expirationTokenTime), (timer) {
      logout();
    });
  }

  Future logout() async {
    _token = null;
    Api.instance.token = null;
    _userId = null;
    Api.instance.userId = null;

    // ignore: no_leading_underscores_for_local_identifiers
    final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
    final SharedPreferences prefs = await _prefs;

    prefs.clear();

    if (_timer != null) {
      _timer?.cancel();
      _timer = null;
    }

    notifyListeners();
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
