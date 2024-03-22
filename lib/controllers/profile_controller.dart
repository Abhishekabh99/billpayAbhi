import 'package:billpe/network/profile_api.dart';

import '../model/profileResponse/store.dart';
import '../model/profileResponse/user.dart';

class ProfileController {
  final ProfileApi _apiService = ProfileApi();

  Future<Map<String, dynamic>> fetchProfileData(String token) async {
    try {
      return await _apiService.fetchProfileData(token);
    } catch (e) {
      rethrow;
    }
  }

  User parseUserData(Map<String, dynamic> data) {
    return User.fromJson(data['user']);
  }

  Store parseStoreData(Map<String, dynamic> data) {
    return Store.fromJson(data['store']);
  }
}
