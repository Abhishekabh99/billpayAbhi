import 'package:dio/dio.dart';

class ProfileApi {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> fetchProfileData(String token) async {
    try {
      final response = await _dio.get(
        'https://billpe.cloud/api/profile',
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      return response.data;
    } catch (e) {
      throw Exception('Failed to fetch profile data: $e');
    }
  }
}
