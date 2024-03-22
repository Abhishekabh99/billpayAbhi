class Store {
  final int? id;
  final String? userId;
  final String? moduleId;
  final String? storeImage;
  final String? shopName;
  final String? latitude;
  final String? longitude;
  final String? address;
  final String? pincode;
  final String? city;
  final String? gst;
  final String? ownerName;
  final String? packageId;
  final String? packageActiveDate;
  final String? packageValidDate;
  final String? packageAmount;
  final String? packageStatus;
  final String? createdAt;
  final String? updatedAt;

  Store({
    required this.id,
    required this.userId,
    required this.moduleId,
    required this.storeImage,
    required this.shopName,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.pincode,
    required this.city,
    required this.gst,
    required this.ownerName,
    required this.packageId,
    required this.packageActiveDate,
    required this.packageValidDate,
    required this.packageAmount,
    required this.packageStatus,
    required this.createdAt,
    required this.updatedAt,
  });

  Store.fromJson(Map<String, dynamic>? json)
      : id = json?['id'] as int?,
        userId = json?['user_id'] as String?,
        moduleId = json?['module_id'] as String?,
        storeImage = json?['store_image'] as String?,
        shopName = json?['shop_name'] as String?,
        latitude = json?['latitude'] as String?,
        longitude = json?['longitude'] as String?,
        address = json?['address'] as String?,
        pincode = json?['pincode'] as String?,
        city = json?['city'] as String?,
        gst = json?['gst'] as String?,
        ownerName = json?['owner_name'] as String?,
        packageId = json?['package_id'] as String?,
        packageActiveDate = json?['package_active_date'] as String?,
        packageValidDate = json?['package_valid_date'] as String?,
        packageAmount = json?['package_amount'] as String?,
        packageStatus = json?['package_status'] as String?,
        createdAt = json?['created_at'] as String?,
        updatedAt = json?['updated_at'] as String? {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'module_id': moduleId,
      'store_image': storeImage,
      'shop_name': shopName,
      'latitude': latitude,
      'longitude': longitude,
      'address': address,
      'pincode': pincode,
      'city': city,
      'gst': gst,
      'owner_name': ownerName,
      'package_id': packageId,
      'package_active_date': packageActiveDate,
      'package_valid_date': packageValidDate,
      'package_amount': packageAmount,
      'package_status': packageStatus,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
