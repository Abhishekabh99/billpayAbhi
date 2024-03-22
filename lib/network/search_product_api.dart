import 'package:billpe/network/logging_interceptor.dart';
import 'package:dio/dio.dart';

import '../model/searchProductResponse/search_product_response.dart';

class SearchProductApi {
  static const String baseUrl = 'https://billpe.cloud/api/searchByProductName';

  final Dio dio = Dio()..interceptors.add(Logging());

  Future<SearchProductResponse> fetchProducts(
      String productName, int storeId, String token) async {
    try {
      final response = await dio.post(
        '$baseUrl',
        data: {
          'product_name': productName,
          'store_id': storeId,
        },
        options: Options(
          contentType: 'application/json; charset=UTF-8',
          headers: {'Authorization': 'Bearer $token'},
        ),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseData = response.data;
        return SearchProductResponse.fromJson(responseData);
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Failed to load products: $e');
    }
  }
}
