import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tukuntech/features/auth/presentation/pages/create_acount.dart';
import 'package:tukuntech/home/presentation/pages/home_page.dart';

enum UserType { clinics, elders }

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  UserType selected = UserType.elders;
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

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

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: [
            // Imagen de fondo opcional (puedes quitarla si no la usas)
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
                  children: [
                    // Logo y título
                    Column(
                      children: [
                        Image.asset('assets/logo.png', height: 170),
                        
                        Text(
                          'TUKUNTECH',
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium!
                              .copyWith(letterSpacing: 2),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'Access your account',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Tarjeta principal
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
                              // Toggle Clinics / Elders
                              CupertinoSlidingSegmentedControl<UserType>(
                                groupValue: selected,
                                backgroundColor: turquoise50,
                                thumbColor: turquoise,
                                padding: const EdgeInsets.all(10),
                                children: const {
                                  UserType.clinics: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 56),
                                      child: Text('Clinics')),
                                  UserType.elders: Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 6, horizontal: 50),
                                      child: Text('Elders')),
                                },
                                onValueChanged: (value) =>
                                    setState(() => selected = value!),
                              ),
                              const SizedBox(height: 44),
                      
                              // Formulario Email + Password
                              Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      controller: _emailCtrl,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: const InputDecoration(
                                        labelText: 'Email',
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 183, 182, 182),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
                                      ),
                                      validator: (value) {
                                        if (value == null ||
                                            value.trim().isEmpty) {
                                          return 'Enter your email';
                                        }
                                        return null;
                                      },
                                    ),
                                    const SizedBox(height: 36),
                                    TextFormField(
                                      controller: _pwdCtrl,
                                      obscureText: true,
                                      decoration: const InputDecoration(
                                        labelText: 'Password',
                                        filled: true,
                                        fillColor: Color.fromARGB(255, 183, 182, 182),
                                        border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10))),
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
                      
                              // Botón Log In
                              SizedBox(
                                width: double.infinity,
                                child: FilledButton(
                                  style: FilledButton.styleFrom(
                                    backgroundColor: turquoise,
                                    foregroundColor: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(40),
                                    ),
                                    padding:
                                        const EdgeInsets.symmetric(vertical:16),
                                  ),
                                  onPressed: () {
                                    if (_formKey.currentState?.validate() ??
                                        false) {
                                      Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => const HomePage()),
                                  );
                                    }
                                  },
                                  child: const Text(
                                    'Log in',
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ),
                      
                              // Enlaces Forgot + Create
                              TextButton(
                                onPressed: () {/* Recuperar contraseña FUNCION DE ADORNO*/},
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
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 14, horizontal: 44),
                                ),

                                // Navega a la pantalla de registro (CreateAccountScreen)
                                onPressed: () {
                                  Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const CreateAccountScreen()),
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
    );
  }
}
