import 'dart:developer';

import 'package:billpe/features/common/unit_model.dart';
import 'package:billpe/global/x_dio.dart';

class CommonApi {
  static Future<List<UnitModel>> getUnit() async {
    try {
      final response = await dio.get("getUnit");
      if (response.statusCode == 200) {
        log("Response: ${response.data}");
        final units = response.data["Unit"];
        return List<UnitModel>.from(units.map((x) => UnitModel.fromJson(x)));
      }
    } catch (e) {
      log("getUnit Failed $e");
    }
    return [];
  }
}
