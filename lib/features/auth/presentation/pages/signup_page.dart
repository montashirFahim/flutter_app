import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:app_1/features/auth/presentation/cubit/auth_states.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _dobController = TextEditingController();
  String? _selectedGender;
  bool isLoading = false;

  void _signUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final password = _passwordController.text.trim();
      final name = _nameController.text.trim();
      final username = _usernameController.text.trim();
      final dob = _dobController.text.trim();
      final gender = _selectedGender;
      context.read<AuthCubit>().register(
        email,
        password,
        name: name,
        username: username,
        dob: dob,
        gender: gender,
      );
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dobController.text = "${picked.day}/${picked.month}/${picked.year}";
      });
    }
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
                setState(() => isLoading = state is AuthLoading);
                if (state is Authenticated) {
                  Navigator.pushReplacementNamed(context, '/feed');
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Welcome, ${state.user.name}')),
                  );
                } else if (state is AuthError) {
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
                              "Sign Up",
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(color: Colors.black),
                            ),
                            const SizedBox(height: 24),
                            _buildTextField(_nameController, 'Name'),
                            const SizedBox(height: 16),
                            _buildTextField(_usernameController, 'Username'),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _emailController,
                              'Email',
                              validator: (val) =>
                                  val != null && val.contains('@')
                                  ? null
                                  : 'Enter a valid email',
                            ),
                            const SizedBox(height: 16),
                            _buildTextField(
                              _passwordController,
                              'Password',
                              obscure: true,
                              validator: (val) => val != null && val.length >= 6
                                  ? null
                                  : 'Min 6 characters required',
                            ),
                            const SizedBox(height: 16),
                            TextFormField(
                              controller: _dobController,
                              decoration: _inputDecoration('Date of Birth'),
                              readOnly: true,
                              style: const TextStyle(color: Colors.black),
                              onTap: () => _selectDate(context),
                              validator: (val) => val != null && val.isNotEmpty
                                  ? null
                                  : 'Select date of birth',
                            ),
                            const SizedBox(height: 16),
                            DropdownButtonFormField<String>(
                              decoration: _inputDecoration('Gender'),
                              value: _selectedGender,
                              dropdownColor: Colors.white,
                              style: const TextStyle(color: Colors.black),
                              items: ['Male', 'Female']
                                  .map(
                                    (gender) => DropdownMenuItem(
                                      value: gender,
                                      child: Text(gender),
                                    ),
                                  )
                                  .toList(),
                              onChanged: (val) =>
                                  setState(() => _selectedGender = val),
                              validator: (val) =>
                                  val != null ? null : 'Select a gender',
                            ),
                            const SizedBox(height: 24),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.lightBlue[200],
                              ),
                              onPressed: isLoading
                                  ? null
                                  : () => _signUp(context),
                              child: isLoading
                                  ? const CircularProgressIndicator(
                                      color: Colors.black,
                                    )
                                  : const Text(
                                      'Sign Up',
                                      style: TextStyle(color: Colors.black),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Already have an account? ",
                                  style: TextStyle(color: Colors.black),
                                ),
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pushNamed(context, '/login'),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                ),
                              ],
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

  InputDecoration _inputDecoration(String label) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black),
      filled: true,
      fillColor: Colors.white, // White background for input fields
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black),
      ),
    );
  }

  Widget _buildTextField(
    TextEditingController controller,
    String label, {
    bool obscure = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      decoration: _inputDecoration(label),
      style: const TextStyle(color: Colors.black),
      validator:
          validator ??
          (val) => val != null && val.isNotEmpty ? null : 'Enter $label',
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
