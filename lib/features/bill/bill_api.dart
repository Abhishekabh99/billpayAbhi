import 'dart:developer';

import 'package:billpe/features/bill/model/bill_category_model.dart';
import 'package:billpe/global/x_dio.dart';

class BillApi {
  static Future<List<BillCategoryModel>> getBillCategory(
      String moduleId) async {
    try {
      Map<String, dynamic> data = {
        "module_id": moduleId,
      };
      final response = await dio.post("getCategory", data: data);
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        final units = response.data["Category"];
        return List<BillCategoryModel>.from(
            units.map((x) => BillCategoryModel.fromJson(x)));
      }
    } catch (e) {
      log("getCategory Failed $e");
    }
    return [];
  }

  static Future<List<BillCategoryModel>> addProduct({
    required String storeId,
    required String moduleId,
    required String categoryId,
    required String barCode,
    required String productName,
    required String unitId,
    required String packageWeight,
    required String quantity,
    required String mrp,
    required String retailPrice,
    required String sellPrice,
    required String memberPrice,
    required String purchasePrice,
    required String stock,
    required String lowStock,
    required String gst,
    required String hsn,
    required String cess,
    required String expiryDate,
    required String tag,
    required String brand,
    required String color,
  }) async {
    try {
      Map<String, dynamic> data = {
        "store_id": storeId,
        "module_id": moduleId,
        "category_id": categoryId,
        "barcode": barCode,
        "name": productName,
        "unit": unitId,
        "package_weight": packageWeight,
        "qtn": quantity,
        "mrp": mrp,
        "retail_price": retailPrice,
        "sell_price": sellPrice,
        "member_price": memberPrice,
        "purchase_price": purchasePrice,
        "stock": stock,
        "low_stock": lowStock,
        "gst": gst,
        "hsn": hsn,
        "CESS": cess,
        "expiry_date": expiryDate,
        "tag": tag,
        "brand": brand,
        "color": color,
      };
      final response = await dio.post("getCategory", data: data);
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        final units = response.data["Category"];
        return List<BillCategoryModel>.from(
            units.map((x) => BillCategoryModel.fromJson(x)));
      }
    } catch (e) {
      log("getCategory Failed $e");
    }
    return [];
  }
}
