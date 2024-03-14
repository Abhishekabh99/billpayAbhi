class StoreModel {
  int? userId;
  String? moduleId;
  dynamic storeImage;
  String? shopName;
  String? latitude;
  String? longitude;
  String? address;
  String? pincode;
  String? city;
  dynamic gst;
  String? ownerName;
  String? updatedAt;
  String? createdAt;
  int? id;

  StoreModel(
      {this.userId,
      this.moduleId,
      this.storeImage,
      this.shopName,
      this.latitude,
      this.longitude,
      this.address,
      this.pincode,
      this.city,
      this.gst,
      this.ownerName,
      this.updatedAt,
      this.createdAt,
      this.id});

  StoreModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    moduleId = json['module_id'];
    storeImage = json['store_image'];
    shopName = json['shop_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    pincode = json['pincode'];
    city = json['city'];
    gst = json['gst'];
    ownerName = json['owner_name'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['module_id'] = moduleId;
    data['store_image'] = storeImage;
    data['shop_name'] = shopName;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['pincode'] = pincode;
    data['city'] = city;
    data['gst'] = gst;
    data['owner_name'] = ownerName;
    data['updated_at'] = updatedAt;
    data['created_at'] = createdAt;
    data['id'] = id;
    return data;
  }
}
