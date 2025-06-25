// lib/features/auth/domain/repositories/auth_repo.dart
import 'package:app_1/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password, {
    String? name,
    String? username,
    String? dob,
    String? gender,
  });
  Future<void> logout();
  Future<AppUser?> getCurrentUser();
  Future<void> forgotPassword(String email);
}
