import 'dart:developer';
import 'package:billpe/global/prefs.dart';

class LocalStorage {
  static const String _keyToken = 'token';

  static String? getToken() {
    try {
      return Prefs.getString(_keyToken);
    } catch (e) {
      log("getTokenData $e");
    }
    return null;
  }

  static Future<void> setToken(String token) async {
    try {
      await Prefs.setString(_keyToken, token);
    } catch (e) {
      log("$e");
    }
  }
}
