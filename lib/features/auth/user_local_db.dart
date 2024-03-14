import 'dart:convert';
import 'dart:developer';

import 'package:billpe/global/model/user_model.dart';
import 'package:billpe/global/prefs.dart';

class UserLocalStorage {
  static const String _userKey = 'user';

  static UserModel? getUserData() {
    try {
      final String? data = Prefs.getString(_userKey);
      if (data != null) {
        final json = jsonDecode(data);
        final user = UserModel.fromJson(json);
        return user;
      }
    } catch (e) {
      log("getUserData $e");
    }
    return null;
  }

  static Future<void> setUserData(Map outerData) async {
    try {
      final String data = json.encode(outerData);
      await Prefs.setString(_userKey, data);
    } catch (e) {
      log("$e");
    }
  }
}
