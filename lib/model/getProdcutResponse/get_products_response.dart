import 'package:flutter/material.dart';

import 'get_prodcucts.dart';

class GetProductResponse {
  final bool? success;
  final String? message;
  final List<Product>? products;

  GetProductResponse({
    this.success,
    this.message,
    this.products,
  });

  GetProductResponse.fromJson(Map<String, dynamic> json)
      : success = json['success'],
        message = json['message'],
        products = (json['Product'] as List<dynamic>?)
            ?.map((product) => Product.fromJson(product))
            .toList();

  Map<String, dynamic> toJson() {
    return {
      'success': success,
      'message': message,
      'Product': products?.map((product) => product.toJson()).toList(),
    };
  }
}
