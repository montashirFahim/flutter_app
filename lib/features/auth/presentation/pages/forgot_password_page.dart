import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_states.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _resetPassword(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      context.read<AuthCubit>().forgotPassword(email);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // White background
      body: Row(
        children: [
          // Sidebar
          Drawer(
            backgroundColor: Colors.white, // White sidebar
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DrawerHeader(
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(255, 111, 200, 241), // Sky blue
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.app_registration, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        'Menu',
                        style: TextStyle(color: Colors.black, fontSize: 24),
                      ),
                    ],
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.login, color: Colors.black),
                  title: const Text(
                    'Login',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/login'),
                ),
                ListTile(
                  leading: const Icon(Icons.person_add, color: Colors.black),
                  title: const Text(
                    'Signup',
                    style: TextStyle(color: Colors.black),
                  ),
                  onTap: () => Navigator.pushNamed(context, '/signup'),
                ),
              ],
            ),
          ),
          // Main Content
          Expanded(
            child: BlocConsumer<AuthCubit, AuthStates>(
              listener: (context, state) {
                if (state is AuthLoading)
                  setState(() => isLoading = true);
                else
                  setState(() => isLoading = false);

                if (state is Unauthenticated) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Password reset email sent')),
                  );
                  Navigator.pushNamed(context, '/login');
                }

                if (state is AuthError) {
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text(state.message)));
                }
              },
              builder: (context, state) {
                return Container(
                  color: Colors.white,
                  padding: const EdgeInsets.all(24.0),
                  child: Center(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            "Reset Password",
                            style: Theme.of(context).textTheme.headlineMedium
                                ?.copyWith(color: Colors.black),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Enter your email to receive a password reset link.',
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _emailController,
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(color: Colors.black),
                              filled: true,
                              fillColor: Colors.white, // White box background
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.black),
                              ),
                            ),
                            style: const TextStyle(color: Colors.black),
                            validator: (val) => val != null && val.contains('@')
                                ? null
                                : 'Enter a valid email',
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  Colors.lightBlue[200], // Sky blue
                            ),
                            onPressed: isLoading
                                ? null
                                : () => _resetPassword(context),
                            child: isLoading
                                ? const CircularProgressIndicator(
                                    color: Colors.black,
                                  )
                                : const Text(
                                    'Send Reset Link',
                                    style: TextStyle(color: Colors.black),
                                  ),
                          ),
                          const SizedBox(height: 16),
                          TextButton(
                            onPressed: () =>
                                Navigator.pushNamed(context, '/login'),
                            child: const Text(
                              'Back to Login',
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }
}
