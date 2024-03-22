class StoreCategoryModel {
  int? id;
  String? userId;
  String? name;
  String? status;
  String? createdAt;
  String? updatedAt;

  StoreCategoryModel(
      {this.id,
      this.userId,
      this.name,
      this.status,
      this.createdAt,
      this.updatedAt});

  StoreCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
