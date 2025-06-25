// lib/features/auth/domain/entities/app_user.dart
class AppUser {
  final String uid;
  final String email;
  final String name;
  final String? username;
  final String? dob;
  final String? gender;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    this.username,
    this.dob,
    this.gender,
  });

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'username': username,
      'dob': dob,
      'gender': gender,
    };
  }

  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
      username: jsonUser['username'],
      dob: jsonUser['dob'],
      gender: jsonUser['gender'],
    );
  }
}
