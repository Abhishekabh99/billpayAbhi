class UserModel {
  int? id;
  dynamic userId;
  String? name;
  String? email;
  dynamic emailVerifiedAt;
  String? whatsappNo;
  String? roleType;
  String? image;
  dynamic aadharNumber;
  dynamic drivingLicence;
  String? uniqueId;
  String? createdAt;
  String? updatedAt;
  String? storeId;

  UserModel(
      {this.id,
      this.userId,
      this.name,
      this.email,
      this.emailVerifiedAt,
      this.whatsappNo,
      this.roleType,
      this.image,
      this.aadharNumber,
      this.drivingLicence,
      this.uniqueId,
      this.createdAt,
      this.storeId,
      this.updatedAt});

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    whatsappNo = json['whatsapp_no'];
    roleType = json['role_type']?.toString();
    image = json['image'];
    aadharNumber = json['aadhar_number'];
    drivingLicence = json['driving_licence'];
    uniqueId = json['unique_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['whatsapp_no'] = whatsappNo;
    data['role_type'] = roleType;
    data['image'] = image;
    data['aadhar_number'] = aadharNumber;
    data['driving_licence'] = drivingLicence;
    data['unique_id'] = uniqueId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
