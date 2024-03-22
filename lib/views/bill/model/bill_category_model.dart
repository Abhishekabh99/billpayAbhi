class BillCategoryModel {
  int? id;
  String? name;
  String? moduleId;
  String? status;
  String? createdAt;
  String? updatedAt;

  BillCategoryModel(
      {this.id,
      this.name,
      this.moduleId,
      this.status,
      this.createdAt,
      this.updatedAt});

  BillCategoryModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    moduleId = json['module_id'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['module_id'] = moduleId;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
