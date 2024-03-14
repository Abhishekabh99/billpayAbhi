import 'dart:convert';
import 'dart:developer';

import 'package:billpe/features/auth/model/store_category_model.dart';
import 'package:billpe/features/auth/model/store_model.dart';
import 'package:billpe/features/auth/store_local_db.dart';
import 'package:billpe/features/auth/user_local_db.dart';
import 'package:billpe/global/model/user_model.dart';
import 'package:billpe/global/x_dio.dart';
import 'package:dio/dio.dart';

class AuthApi {
  static sendOtp(String phoneNumber) async {
    final phoneNumberWithCountryCode = phoneNumber;
    log("Sending OTP to $phoneNumberWithCountryCode");
    try {
      Map<String, dynamic> data = {"phone": phoneNumberWithCountryCode};
      final response = await dio.post("send-OTP", data: data);
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        return response.data;
      }
    } catch (e) {
      log("send-OTP Failed $e");
    }
  }

  static Future<(UserModel?, bool)> verifyOTP(
      String phoneNumber, String otp) async {
    log("Verifying OTP to $phoneNumber with $otp");
    try {
      Map<String, dynamic> data = {"phone": phoneNumber, "otp": otp};
      final response = await dio.post("verify-OTP", data: data);
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        if ((response.data as Map).containsKey("data")) {
          await UserLocalStorage.setUserData(response.data["data"]);
          return (UserModel.fromJson(response.data["data"]), true);
        } else {
          return (null, true);
        }
      }
    } catch (e) {
      log("verify-OTP Failed $e");
    }
    return (null, false);
  }

  static Future<(StoreModel?, bool)> addUser(
      {required String storeName,
      required String email,
      required String storeType,
      required String whatsappNumber,
      required String gstNumber,
      required String address,
      required String latitude,
      required String longitude,
      required String pincode,
      required String city,
      required String ownerName}) async {
    log("Saving store details for $storeName");
    try {
      Map<String, dynamic> data = {
        "name": storeName,
        "email": email,
        "whatsapp_no": whatsappNumber,
        "store_type": storeType,
        "shop_name": storeName,
        "address": address,
        "latitude": latitude,
        "longitude": longitude,
        "pincode": pincode,
        "city": city,
        "gst": gstNumber,
        "owner_name": ownerName,
        "role_type": 2,
      };
      final response = await dio.post("add-User", data: data);
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        if ((response.data as Map).containsKey("data")) {
          await UserLocalStorage.setUserData(response.data["data"]);
        }
        if ((response.data as Map).containsKey("store")) {
          log(jsonEncode(response.data["store"]));
          await StoreLocalStorage.setStoreData(response.data["store"]);
          final store = StoreModel.fromJson(response.data["store"]);
          return (store, response.data['success'] as bool);
        }
      }
    } catch (e) {
      log("add-User Failed $e");
    }
    return (null, false);
  }

  static uploadStoreImage(String phoneNumber, String filePath, String fileName,
      String storeID) async {
    final data = FormData.fromMap({
      'files': [await MultipartFile.fromFile(filePath, filename: fileName)],
      'store_id': storeID,
    });
    try {
      final response = await dio.post("update-StoreImage", data: data);
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        return response.data;
      }
    } catch (e) {
      log("update-StoreImage Failed $e");
    }
  }

  static Future<List<StoreCategoryModel>> getStoreCategories() async {
    try {
      final response = await dio.get("getModule");
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        final module = response.data["Module"];
        return List<StoreCategoryModel>.from(
            module.map((x) => StoreCategoryModel.fromJson(x)));
      }
    } catch (e) {
      log("getModule Failed $e");
    }
    return [];
  }
}
