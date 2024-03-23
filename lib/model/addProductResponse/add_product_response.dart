class AddProductResponse {
  final bool success;
  final String message;
  final Map<String, dynamic>? data;

  AddProductResponse({
    required this.success,
    required this.message,
    this.data,
  });

  factory AddProductResponse.fromJson(Map<String, dynamic> json) {
    return AddProductResponse(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      data: json['data'],
    );
  }
}
