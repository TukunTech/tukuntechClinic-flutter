import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tukuntech/features/auth/presentation/blocs/auth_event.dart';
import 'package:tukuntech/features/auth/presentation/blocs/auth_state.dart';
import 'package:tukuntech/features/auth/presentation/pages/create_acount.dart';
import 'package:tukuntech/home/presentation/pages/home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  bool showErrorMessage = false;
  bool hasFieldError = false;

  @override
  void dispose() {
    _emailCtrl.dispose();
    _pwdCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const turquoise = Color(0xFF00A3B2);
    const turquoise50 = Color(0xFFB7E6EC);
    const tealGrey = Color(0xFF6EB7BC);

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const Center(child: CircularProgressIndicator()),
          );
        } else if (state is AuthSuccess) {
          Navigator.of(context).pop(); // Close loading
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const HomePage()),
          );
        } else if (state is AuthFailure) {
          Navigator.of(context).pop(); // Close loading
          setState(() {
            showErrorMessage = true;
            hasFieldError = true;
          });
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/fondo_login.jpg',
                  fit: BoxFit.cover,
                  alignment: Alignment.centerRight,
                ),
              ),
              Center(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Header card with logo and title
                      Card(
                        elevation: 6,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        color: Colors.white.withOpacity(0.92),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 20),
                          child: Column(
                            children: [
                              Image.asset('assets/logo.png', height: 70),
                              const SizedBox(height: 10),
                              const Text(
                                'TUKUNTECH',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                  color: Color(0xFF333333),
                                ),
                              ),
                              const SizedBox(height: 6),
                              const Text(
                                'Access your account',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Elder badge
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        margin: const EdgeInsets.only(bottom: 24),
                        decoration: BoxDecoration(
                          color: turquoise50,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Text(
                          'Elder',
                          style: TextStyle(
                            color: turquoise,
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),

                      // Login card
                      SizedBox(
                        height: 550,
                        child: Card(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(54, 8, 54, 8),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Form
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TextFormField(
                                        controller: _emailCtrl,
                                        onChanged: (_) {
                                          if (showErrorMessage ||
                                              hasFieldError) {
                                            setState(() {
                                              showErrorMessage = false;
                                              hasFieldError = false;
                                            });
                                          }
                                        },
                                        keyboardType:
                                            TextInputType.emailAddress,
                                        decoration: InputDecoration(
                                          labelText: 'Username',
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 183, 182, 182),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide:
                                                      const BorderSide(
                                                          color: Colors.red)),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Enter your username';
                                          }
                                          return null;
                                        },
                                      ),
                                      const SizedBox(height: 36),
                                      TextFormField(
                                        controller: _pwdCtrl,
                                        onChanged: (_) {
                                          if (showErrorMessage ||
                                              hasFieldError) {
                                            setState(() {
                                              showErrorMessage = false;
                                              hasFieldError = false;
                                            });
                                          }
                                        },
                                        obscureText: true,
                                        decoration: InputDecoration(
                                          labelText: 'Password',
                                          filled: true,
                                          fillColor: const Color.fromARGB(
                                              255, 183, 182, 182),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius:
                                                  BorderRadius.circular(10)),
                                          errorBorder: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: const BorderSide(
                                                  color: Colors.red)),
                                          focusedErrorBorder:
                                              OutlineInputBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  borderSide:
                                                      const BorderSide(
                                                          color: Colors.red)),
                                        ),
                                        validator: (value) {
                                          if (value == null ||
                                              value.trim().isEmpty) {
                                            return 'Enter your password';
                                          }
                                          return null;
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 54),

                                // Login button
                                SizedBox(
                                  width: double.infinity,
                                  child: FilledButton(
                                    style: FilledButton.styleFrom(
                                      backgroundColor: turquoise,
                                      foregroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(40),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 16),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ??
                                          false) {
                                        context.read<AuthBloc>().add(
                                              LoginSubmitted(
                                                username:
                                                    _emailCtrl.text.trim(),
                                                password:
                                                    _pwdCtrl.text.trim(),
                                              ),
                                            );
                                      }
                                    },
                                    child: const Text(
                                      'Log in',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                ),

                                // Error message
                                if (showErrorMessage)
                                  const Padding(
                                    padding: EdgeInsets.only(top: 12.0),
                                    child: Text(
                                      'Incorrect username or password',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),

                                // Forgot password and Create Account
                                TextButton(
                                  onPressed: () {},
                                  child: const Text(
                                    'Forgot my password',
                                    style: TextStyle(
                                        decoration: TextDecoration.underline),
                                  ),
                                ),
                                const Divider(thickness: 1),
                                const SizedBox(height: 8),
                                const Text("Don't have an account?"),
                                const SizedBox(height: 8),
                                OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: tealGrey,
                                    side: BorderSide.none,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 14, horizontal: 44),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccountScreen()),
                                    );
                                  },
                                  child: const Text(
                                    'Create an account',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
