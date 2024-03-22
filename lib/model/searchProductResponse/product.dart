import 'package:flutter/material.dart';

class Product {
  final int? id;
  final String? userId;
  final int? storeId;
  final String? moduleId;
  final String? category;
  final String? barcode;
  final String? productImage;
  final String? productName;
  final String? unit;
  final String? packageWeight;
  final String? quantity;
  final double? mrp;
  final double? retailPrice;
  final double? sellPrice;
  final double? membersPrice;
  final double? purchasePrice;
  final int? stock;
  final int? lowStock;
  final dynamic gst;
  final dynamic hsn;
  final dynamic cess;
  final dynamic expiry;
  final dynamic tags;
  final dynamic brand;
  final dynamic color;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Product({
    this.id,
    this.userId,
    this.storeId,
    this.moduleId,
    this.category,
    this.barcode,
    this.productImage,
    this.productName,
    this.unit,
    this.packageWeight,
    this.quantity,
    this.mrp,
    this.retailPrice,
    this.sellPrice,
    this.membersPrice,
    this.purchasePrice,
    this.stock,
    this.lowStock,
    this.gst,
    this.hsn,
    this.cess,
    this.expiry,
    this.tags,
    this.brand,
    this.color,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      userId: json['user_id'] as String?,
      storeId: int.tryParse(json['store_id'].toString()),
      moduleId: json['module_id'] as String?,
      category: json['category'] as String?,
      barcode: json['barcode'] as String?,
      productImage: json['product_image'] as String?,
      productName: json['product_name'] as String?,
      unit: json['unit'] as String?,
      packageWeight: json['package_weight'] as String?,
      quantity: json['quantity'] as String?,
      mrp: json['mrp'] != null ? double.tryParse(json['mrp'].toString()) : null,
      retailPrice: json['retail_price'] != null
          ? double.tryParse(json['retail_price'].toString())
          : null,
      sellPrice: json['sell_price'] != null
          ? double.tryParse(json['sell_price'].toString())
          : null,
      membersPrice: json['members_price'] != null
          ? double.tryParse(json['members_price'].toString())
          : null,
      purchasePrice: json['purchase_price'] != null
          ? double.tryParse(json['purchase_price'].toString())
          : null,
      stock:
          json['stock'] != null ? int.tryParse(json['stock'].toString()) : null,
      lowStock: json['low_stock'] != null
          ? int.tryParse(json['low_stock'].toString())
          : null,
      gst: json['gst'],
      hsn: json['hsn'],
      cess: json['cess'],
      expiry: json['expiry'],
      tags: json['tags'],
      brand: json['brand'],
      color: json['color'],
      status: json['status'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'store_id': storeId,
      'module_id': moduleId,
      'category': category,
      'barcode': barcode,
      'product_image': productImage,
      'product_name': productName,
      'unit': unit,
      'package_weight': packageWeight,
      'quantity': quantity,
      'mrp': mrp,
      'retail_price': retailPrice,
      'sell_price': sellPrice,
      'members_price': membersPrice,
      'purchase_price': purchasePrice,
      'stock': stock,
      'low_stock': lowStock,
      'gst': gst,
      'hsn': hsn,
      'cess': cess,
      'expiry': expiry,
      'tags': tags,
      'brand': brand,
      'color': color,
      'status': status,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
