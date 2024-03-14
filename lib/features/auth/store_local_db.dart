import 'dart:convert';
import 'dart:developer';

import 'package:billpe/features/auth/model/store_model.dart';
import 'package:billpe/global/prefs.dart';

class StoreLocalStorage {
  static const String _storeKey = 'store';

  static StoreModel? getStoreData() {
    try {
      final String? data = Prefs.getString(_storeKey);
      if (data != null) {
        final json = jsonDecode(data);
        final store = StoreModel.fromJson(json);
        return store;
      }
    } catch (e) {
      log("getStoreData $e");
    }
    return null;
  }

  static Future<void> setStoreData(Map outerData) async {
    try {
      final String data = json.encode(outerData);
      await Prefs.setString(_storeKey, data);
    } catch (e) {
      log("setUserData $e");
    }
  }
}
