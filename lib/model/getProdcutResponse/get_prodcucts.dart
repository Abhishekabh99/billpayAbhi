class Product {
  final int? id;
  final String? userId;
  final String? storeId;
  final String? moduleId;
  final String? category;
  final String? barcode;
  final String? productImage;
  final String? productName;
  final String? unit;
  final String? packageWeight;
  final String? quantity;
  final dynamic? mrp;
  final dynamic? retailPrice;
  final dynamic? sellPrice;
  final dynamic? membersPrice;
  final dynamic? purchasePrice;
  final dynamic? stock;
  final dynamic? lowStock;
  final dynamic? gst;
  final dynamic? hsn;
  final dynamic? cess;
  final dynamic? expiry;
  final dynamic? tags;
  final dynamic? brand;
  final dynamic? color;
  final String? status;
  final String? createdAt;
  final String? updatedAt;

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
      id: json['id'],
      userId: json['user_id'],
      storeId: json['store_id'],
      moduleId: json['module_id'],
      category: json['category'],
      barcode: json['barcode'],
      productImage: json['product_image'],
      productName: json['product_name'],
      unit: json['unit'],
      packageWeight: json['package_weight'],
      quantity: json['quantity'],
      mrp: json['mrp'],
      retailPrice: json['retail_price'],
      sellPrice: json['sell_price'],
      membersPrice: json['members_price'],
      purchasePrice: json['purchase_price'],
      stock: json['stock'],
      lowStock: json['low_stock'],
      gst: json['gst'],
      hsn: json['hsn'],
      cess: json['cess'],
      expiry: json['expiry'],
      tags: json['tags'],
      brand: json['brand'],
      color: json['color'],
      status: json['status'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
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
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
