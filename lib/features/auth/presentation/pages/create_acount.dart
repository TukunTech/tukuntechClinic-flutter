import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/auth/data/models/register_dto.dart';
import 'package:tukuntech/features/auth/presentation/blocs/register_bloc.dart';
import 'package:tukuntech/features/auth/presentation/blocs/register_event.dart';
import 'package:tukuntech/features/auth/presentation/blocs/register_state.dart';
import 'login.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();

  @override
  void dispose() {
    _usernameCtrl.dispose();
    _pwdCtrl.dispose();
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  void _showLoadingDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const turquoise = Color(0xFF00A3B2);
    const turquoise50 = Color(0xFFB7E6EC);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: BlocListener<RegisterBloc, RegisterState>(
          listener: (context, state) {
            if (state is RegisterLoading) {
              _showLoadingDialog();
            } else if (state is RegisterSuccess) {
              Navigator.of(context).pop(); // close loading
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Account created successfully!'),
                  backgroundColor: Colors.green,
                ),
              );
              Future.delayed(const Duration(milliseconds: 1500), () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                );
              });
            } else if (state is RegisterError) {
              Navigator.of(context).pop(); // close loading
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/fondo_login.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    children: [
                      // Logo y título en tarjeta
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        color: Colors.white,
                        elevation: 12,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 16),
                          child: Column(
                            children: [
                              Image.asset('assets/logo.png', height: 80),
                              const SizedBox(height: 10),
                              const Text(
                                'TUKUNTECH',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 2),
                              ),
                              const Text(
                                'Create an account',
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Formulario
                      Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24)),
                        elevation: 8,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(30, 24, 30, 24),
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 6, horizontal: 24),
                                decoration: BoxDecoration(
                                  color: turquoise50,
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                child: const Text(
                                  'Elder',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: turquoise),
                                ),
                              ),
                              const SizedBox(height: 24),
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    _buildTextField(_firstNameCtrl, 'First name'),
                                    _buildTextField(_lastNameCtrl, 'Last name'),
                                    _buildTextField(_usernameCtrl, 'Username'),
                                    _buildTextField(_emailCtrl, 'Email',
                                        TextInputType.emailAddress),
                                    _buildTextField(_pwdCtrl, 'Password',
                                        TextInputType.text, true),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 16),
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: turquoise,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    padding: const EdgeInsets.symmetric(vertical: 16),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState!.validate()) {
                                      final dto = RegisterDTO(
                                        username: _usernameCtrl.text.trim(),
                                        password: _pwdCtrl.text.trim(),
                                        firstName: _firstNameCtrl.text.trim(),
                                        lastName: _lastNameCtrl.text.trim(),
                                        email: _emailCtrl.text.trim(),
                                      );
                                      context
                                          .read<RegisterBloc>()
                                          .add(RegisterSubmitted(dto));
                                    }
                                  },
                                  child: const Text('Create', style: TextStyle(fontSize: 18)),
                                ),
                              ),
                              const SizedBox(height: 16),
                              const Text("Already have an account?"),
                              const SizedBox(height: 8),
                              OutlinedButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('Access your account'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(TextEditingController controller, String label,
      [TextInputType type = TextInputType.text, bool obscure = false]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: label,
          filled: true,
          fillColor: const Color.fromARGB(255, 183, 182, 182),
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              borderSide: BorderSide.none),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Enter your $label';
          }
          return null;
        },
      ),
    );
  }
}
