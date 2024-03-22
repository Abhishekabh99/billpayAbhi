class UserData {
  dynamic user_id;
  String? name;
  String? email;
  // int? role_type;
  String? whatsapp_no;
  dynamic image;
  String? unique_id;
  dynamic aadhar_number;
  dynamic driving_licence;
  String? updated_at;
  String? created_at;
  int? id;

  UserData({
    this.user_id,
    this.name,
    this.email,
    // this.role_type,
    this.whatsapp_no,
    this.image,
    this.unique_id,
    this.aadhar_number,
    this.driving_licence,
    this.updated_at,
    this.created_at,
    this.id,
  });

  UserData.fromJson(Map<String, dynamic> json) {
    user_id = json['user_id'];
    name = json['name'];
    email = json['email'];
    // role_type = json['role_type'];
    whatsapp_no = json['whatsapp_no'];
    image = json['image'];
    unique_id = json['unique_id'];
    aadhar_number = json['aadhar_number'];
    driving_licence = json['driving_licence'];
    updated_at = json['updated_at'];
    created_at = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = user_id;
    data['name'] = name;
    data['email'] = email;
    // data['role_type'] = role_type;
    data['whatsapp_no'] = whatsapp_no;
    data['image'] = image;
    data['unique_id'] = unique_id;
    data['aadhar_number'] = aadhar_number;
    data['driving_licence'] = driving_licence;
    data['updated_at'] = updated_at;
    data['created_at'] = created_at;
    data['id'] = id;
    return data;
  }
}
