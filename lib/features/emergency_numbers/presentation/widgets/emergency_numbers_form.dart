import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/emergency_numbers.dart';
import '../blocs/emergency_numbers_bloc.dart';
import '../blocs/emergency_numbers_event.dart';

class EmergencyContactForm extends StatefulWidget {
  const EmergencyContactForm({super.key});

  @override
  State<EmergencyContactForm> createState() => _EmergencyContactFormState();
}

class _EmergencyContactFormState extends State<EmergencyContactForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    print('[Form] Agregando contacto: $name - $phone');

    final contact = EmergencyContact(id: 0, name: name, phone: phone);

    context.read<EmergencyNumbersBloc>().add(AddEmergencyContact(contact));

    _nameController.clear();
    _phoneController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contacto "$name" enviado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'Name'),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Este campo es obligatorio';
              }
              return null;
            },
          ),
          TextFormField(
            controller: _phoneController,
            decoration: const InputDecoration(labelText: 'Phone'),
            keyboardType: TextInputType.phone,
            maxLength: 9,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Este campo es obligatorio';
              }
              if (!RegExp(r'^\d{9}$').hasMatch(value.trim())) {
                return 'El número debe tener exactamente 9 dígitos';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: _submit,
            child: const Text('Add Contact'),
          ),
        ],
      ),
    );
  }
}
