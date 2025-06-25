import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_states.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  void _login(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      context.read<AuthCubit>().login(email, password);
    }
  }

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white, // white background inside input boxes
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          // Sidebar
          Drawer(
            backgroundColor: Colors.white,
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                const DrawerHeader(
                  decoration: BoxDecoration(
                    color: Color.fromARGB(255, 111, 200, 241),
                  ),
                  child: Row(
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
                if (state is Authenticated) {
                  Navigator.pushReplacementNamed(context, '/feed');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Welcome, ${state.user.name}')),
                  );
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
                    child: SingleChildScrollView(
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              "Login",
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 24),
                            TextFormField(
                              controller: _emailController,
                              decoration: _inputDecoration('Email'),
                              style: const TextStyle(color: Colors.black),
                              validator: (val) =>
                                  val != null && val.contains('@')
                                  ? null
                                  : 'Enter a valid email',
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _passwordController,
                              decoration: _inputDecoration('Password'),
                              obscureText: true,
                              style: const TextStyle(color: Colors.black),
                              validator: (val) => val != null && val.length >= 6
                                  ? null
                                  : 'Min 6 characters required',
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[200],
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () => _login(context),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : const Text(
                                      'Login',
                                      style: TextStyle(color: Colors.black),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have an account?",
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/signup'),
                                  child: const Text(
                                    "Sign up",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: () => Navigator.pushNamed(
                                context,
                                '/forgot-password',
                              ),
                              child: const Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
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
    _passwordController.dispose();
    super.dispose();
  }
}
