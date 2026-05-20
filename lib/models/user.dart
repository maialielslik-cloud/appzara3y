

class UserModel {
  final String uid;
  final String name;
  final String email;
  final String password; // الحقل الجديد

  UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.password, // ضيفيه هنا
  });

  factory UserModel.fromMap(Map<String, dynamic> map, String id) {
    return UserModel(
      uid: id,
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      password: map['password'] ?? '', // اسحبيه من الماب
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "email": email,
      "password": password, // ابعتيه للـ Firestore
    };
  }
}