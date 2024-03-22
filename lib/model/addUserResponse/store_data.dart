class StoreData {
  int? user_id;
  int? module_id;
  dynamic store_image;
  String? shop_name;
  double? latitude;
  double? longitude;
  String? address;
  int? pincode;
  String? city;
  dynamic gst;
  String? owner_name;
  String? updated_at;
  String? created_at;
  int? id;

  StoreData({
    this.user_id,
    this.module_id,
    this.store_image,
    this.shop_name,
    this.latitude,
    this.longitude,
    this.address,
    this.pincode,
    this.city,
    this.gst,
    this.owner_name,
    this.updated_at,
    this.created_at,
    this.id,
  });

  StoreData.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    module_id = json['module_id'];
    store_image = json['store_image'];
    shop_name = json['shop_name'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    address = json['address'];
    pincode = json['pincode'];
    city = json['city'];
    gst = json['gst'];
    owner_name = json['owner_name'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['module_id'] = module_id;
    data['store_image'] = store_image;
    data['shop_name'] = shop_name;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['address'] = address;
    data['pincode'] = pincode;
    data['city'] = city;
    data['gst'] = gst;
    data['owner_name'] = owner_name;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    data['id'] = id;
    return data;
  }
}
