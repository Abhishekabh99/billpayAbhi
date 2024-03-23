import 'dart:convert';
import 'package:http/http.dart' as http;

import '../model/getProdcutResponse/get_products_response.dart';

class GetProductApi {
  static const String apiUrl = 'https://billpe.cloud/api/getProduct';

  static Future<GetProductResponse> getProduct(
      String storeId, String token) async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, String>{
        'store_id': storeId,
      }),
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      return GetProductResponse.fromJson(jsonResponse);
    } else {
      throw Exception('Failed to load products: ${response.statusCode}');
    }
  }
}
