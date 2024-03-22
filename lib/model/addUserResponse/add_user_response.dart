import 'store_data.dart';
import 'user_data.dart';

class AddUserResponse {
  bool? success;
  String? message;
  String? token;
  // coming from add user API
  UserData? data;
  // coming from profile API
  UserData? user;
  StoreData? store;

  AddUserResponse(
      {this.success,
      this.message,
      this.token,
      this.data,
      this.store,
      this.user});

  AddUserResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
    store = json['store'] != null ? StoreData.fromJson(json['store']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    if (store != null) {
      data['store'] = this.store!.toJson();
    }
    return data;
  }
}
