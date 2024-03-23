import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:billpe/model/searchProductResponse/product.dart';

class AddProductApi {
  static const String _baseUrl = 'https://billpe.cloud/api';

  static Future<Map<String, dynamic>> postProduct(
      Product product, String token) async {
    final String apiUrl = '$_baseUrl/getProduct';
    final Map<String, dynamic> requestData = {
      'store_id': 3, // Replace with your store ID
      'name': product.productName ?? '',
      'qtn': product.quantity ?? 0,
      'category_id': null, // Add category ID if available
      'unit': product.unit ?? '',
      'barcode': product.barcode ?? '',
      'package_weight': product.packageWeight ?? '',
      'mrp': product.mrp ?? null,
      'retail_price': product.retailPrice ?? null,
      'sell_price': product.sellPrice ?? null,
      // 'member_price': product.memberPrice ?? null,
      'purchase_price': product.purchasePrice ?? null,
      'stock': product.stock ?? null,
      'low_stock': product.lowStock ?? null,
      'gst': product.gst ?? null,
      'hsn': product.hsn ?? null,
      'CESS': product.cess ?? null,
      'expiry_date': null, // Add expiry date if available
      // 'tag': product.tag ?? '',
      'brand': product.brand ?? '',
      'color': product.color ?? '',
    };

    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = jsonDecode(response.body);
      return responseData;
    } else {
      throw Exception('Failed to post product: ${response.statusCode}');
    }
  }
}
