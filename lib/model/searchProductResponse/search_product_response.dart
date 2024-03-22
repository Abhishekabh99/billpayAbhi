import 'package:flutter/material.dart';
import 'package:billpe/model/searchProductResponse/product.dart';

class SearchProductResponse {
  final bool? success;
  final String? message;
  final List<Product>? products;

  SearchProductResponse({
    this.success,
    this.message,
    this.products,
  });

  factory SearchProductResponse.fromJson(Map<String, dynamic> json) {
    return SearchProductResponse(
      success: json['success'],
      message: json['message'],
      products: (json['Product'] as List<dynamic>?)
          ?.map((x) => Product.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'Product': products?.map((product) => product.toJson()).toList(),
    };
  }
}
