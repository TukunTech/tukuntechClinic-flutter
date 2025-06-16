import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum UserType { clinics, elders }

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  UserType selected = UserType.elders;

  final _nameCtrl = TextEditingController();
  final _lastnameCtrl = TextEditingController();
  final _emailCtrl = TextEditingController();
  final _phoneCtrl = TextEditingController();
  final _dniCtrl = TextEditingController();
  final _pwdCtrl = TextEditingController();

  @override
  void dispose() {
    _nameCtrl.dispose();
    _lastnameCtrl.dispose();
    _emailCtrl.dispose();
    _phoneCtrl.dispose();
    _dniCtrl.dispose();
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
                    Image.asset('assets/logo.png', height: 100),
                    const SizedBox(height: 8),
                    Text(
                      'TUKUNTECH',
                      style: Theme.of(context).textTheme.titleMedium!.copyWith(letterSpacing: 2),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Create an account',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 32),
                    Card(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                      elevation: 8,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(30, 16, 30, 16),
                        child: Column(
                          children: [
                            CupertinoSlidingSegmentedControl<UserType>(
                              groupValue: selected,
                              backgroundColor: turquoise50,
                              thumbColor: turquoise,
                              padding: const EdgeInsets.all(10),
                              children: const {
                                UserType.clinics: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                                  child: Text('Clinics'),
                                ),
                                UserType.elders: Padding(
                                  padding: EdgeInsets.symmetric(vertical: 6, horizontal: 40),
                                  child: Text('Elders'),
                                ),
                              },
                              onValueChanged: (value) => setState(() => selected = value!),
                            ),
                            const SizedBox(height: 24),
                            Form(
                              key: _formKey,
                              child: Column(
                                children: [
                                  _buildTextField(_nameCtrl, 'Name'),
                                  _buildTextField(_lastnameCtrl, 'Lastname'),
                                  _buildTextField(_emailCtrl, 'Email', TextInputType.emailAddress),
                                  _buildTextField(_phoneCtrl, 'Phone', TextInputType.phone),
                                  _buildTextField(_dniCtrl, 'DNI'),
                                  _buildTextField(_pwdCtrl, 'Password', TextInputType.text),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            const Text("Already have an account?"),
                            const SizedBox(height: 8),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                backgroundColor: tealGrey,
                                side: BorderSide.none,
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 44),
                              ),
                              onPressed: () {
                                // TODO: Navegar al login
                                Navigator.pop(context);
                              },
                              child: const Text('Access your account'),
                            ),
                            const Divider(thickness: 1),
                            const SizedBox(height: 8),
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
                                    // TODO: Registro de usuario
                                  }
                                },
                                child: const Text('Create', style: TextStyle(fontSize: 18)),
                              ),
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
