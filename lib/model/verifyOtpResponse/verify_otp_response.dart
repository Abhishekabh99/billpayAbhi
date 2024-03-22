import 'package:billpe/model/addUserResponse/add_user_response.dart';

import '../addUserResponse/user_data.dart';

class VerifyOtpResponse {
  bool? success;
  String? message;
  String? token;
  UserData? data;

  VerifyOtpResponse({this.success, this.message, this.token, this.data});

  VerifyOtpResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    token = json['token'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['token'] = token;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
