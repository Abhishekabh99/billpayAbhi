class UnitModel {
  int? id;
  String? name;
  Null attribute;
  String? createdAt;
  String? updatedAt;

  UnitModel(
      {this.id, this.name, this.attribute, this.createdAt, this.updatedAt});

  UnitModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    attribute = json['attribute'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['attribute'] = attribute;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
