// lib/main.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/core/di/injection_container.dart' as di;
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/auth/presentation/pages/login_page.dart';
import 'package:app_1/features/auth/presentation/pages/signup_page.dart';
import 'package:app_1/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:app_1/features/feed/presentation/cubit/feed_cubit.dart';
import 'package:app_1/features/feed/presentation/pages/feed_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.sl<AuthCubit>()..checkAuthStatus()),
        BlocProvider(create: (_) => di.sl<FeedCubit>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/login',
        routes: {
          '/login': (context) => const LoginPage(),
          '/signup': (context) => const SignUpPage(),
          '/forgot-password': (context) => const ForgotPasswordPage(),
          '/feed': (context) => const FeedPage(),
        },
      ),
    );
  }
}
