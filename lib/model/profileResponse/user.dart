// user.dart

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? whatsappNo;
  // Add other fields as necessary

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.whatsappNo,
    // Add other fields as necessary
  });

  User.fromJson(Map<String, dynamic>? json)
      : id = json?['id'] as int?,
        name = json?['name'] as String?,
        email = json?['email'] as String?,
        whatsappNo = json?['whatsapp_no'] as String? {
    if (json == null) {
      throw ArgumentError('json must not be null');
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'whatsapp_no': whatsappNo,
      // Add other fields as necessary
    };
  }
}
