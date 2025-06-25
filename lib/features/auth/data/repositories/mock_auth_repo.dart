// lib/features/auth/data/repositories/mock_auth_repo.dart
import 'package:app_1/core/util/mock_data.dart';
import 'package:app_1/features/auth/data/models/app_user_model.dart';
import 'package:app_1/features/auth/domain/entities/app_user.dart';
import 'package:app_1/features/auth/domain/repositories/auth_repo.dart';
import 'package:uuid/uuid.dart';

class MockAuthRepo implements AuthRepo {
  AppUser? _currentUser;

  @override
  Future<AppUser?> loginWithEmailPassword(String email, String password) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    final userData = mockUsers.firstWhere(
      (user) => user['email'] == email && user['password'] == password,
      orElse: () => {},
    );
    if (userData.isNotEmpty) {
      _currentUser = AppUserModel.fromJson(userData);
      return _currentUser;
    }
    throw Exception('Invalid email or password');
  }

  @override
  Future<AppUser?> registerWithEmailPassword(
    String email,
    String password, {
    String? name,
    String? username,
    String? dob,
    String? gender,
  }) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (mockUsers.any((user) => user['email'] == email)) {
      throw Exception('Email already exists');
    }
    final newUser = AppUserModel(
      uid: const Uuid().v4(),
      email: email,
      name: name ?? 'User',
      username: username,
      dob: dob,
      gender: gender,
    );
    mockUsers.add({...newUser.toJson(), 'password': password});
    _currentUser = newUser;
    return newUser;
  }

  @override
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    _currentUser = null;
  }

  @override
  Future<AppUser?> getCurrentUser() async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    return _currentUser;
  }

  @override
  Future<void> forgotPassword(String email) async {
    await Future.delayed(const Duration(seconds: 1)); // Simulate network delay
    if (!mockUsers.any((user) => user['email'] == email)) {
      throw Exception('Email not found');
    }
  }
}
