// lib/features/auth/data/models/app_user_model.dart
import 'package:app_1/features/auth/domain/entities/app_user.dart';

class AppUserModel extends AppUser {
  AppUserModel({
    required super.uid,
    required super.email,
    required super.name,
    super.username,
    super.dob,
    super.gender,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    return AppUserModel(
      uid: json['uid'],
      email: json['email'],
      name: json['name'],
      username: json['username'],
      dob: json['dob'],
      gender: json['gender'],
    );
  }

  @override
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
}
