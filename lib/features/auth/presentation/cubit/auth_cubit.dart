// lib/features/auth/presentation/cubit/auth_cubit.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/features/auth/domain/entities/app_user.dart';
import 'package:app_1/features/auth/domain/repositories/auth_repo.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_states.dart';

class AuthCubit extends Cubit<AuthStates> {
  final AuthRepo authRepo;
  AppUser? _currentUser;

  AuthCubit({required this.authRepo}) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());
    try {
      _currentUser = await authRepo.getCurrentUser();
      if (_currentUser != null) {
        emit(Authenticated(_currentUser!));
      } else {
        emit(Unauthenticated());
      }
    } catch (e) {
      emit(AuthError("Failed to check auth status: $e"));
    }
  }

  AppUser? getCurrentUser() => _currentUser;

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      _currentUser = await authRepo.loginWithEmailPassword(email, password);
      if (_currentUser != null) {
        emit(Authenticated(_currentUser!));
      } else {
        emit(AuthError("Login failed"));
      }
    } catch (e) {
      emit(AuthError("Login error: $e"));
    }
  }

  Future<void> register(
    String email,
    String password, {
    String? name,
    String? username,
    String? dob,
    String? gender,
  }) async {
    emit(AuthLoading());
    try {
      _currentUser = await authRepo.registerWithEmailPassword(
        email,
        password,
        name: name,
        username: username,
        dob: dob,
        gender: gender,
      );
      if (_currentUser != null) {
        emit(Authenticated(_currentUser!));
      } else {
        emit(AuthError("Registration failed"));
      }
    } catch (e) {
      emit(AuthError("Registration error: $e"));
    }
  }

  Future<void> forgotPassword(String email) async {
    emit(AuthLoading());
    try {
      await authRepo.forgotPassword(email);
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError("Password reset failed: $e"));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());
    try {
      await authRepo.logout();
      _currentUser = null;
      emit(Unauthenticated());
    } catch (e) {
      emit(AuthError("Logout failed: $e"));
    }
  }
}
