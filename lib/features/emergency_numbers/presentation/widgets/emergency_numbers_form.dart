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
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();

  Future<void> _submit() async {
    final name = _nameController.text.trim();
    final phone = _phoneController.text.trim();

    if (name.isEmpty || phone.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Completa ambos campos')),
      );
      return;
    }

    print('[Form] Agregando contacto: $name - $phone');

    final contact = EmergencyContact(id: 0, name: name, phone: phone);

    // ENVÍO del evento
    context.read<EmergencyNumbersBloc>().add(AddEmergencyContact(contact));

    _nameController.clear();
    _phoneController.clear();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Contacto "$name" enviado')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(labelText: 'Phone'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: _submit,
          child: const Text('Add Contact'),
        ),
      ],
    );
  }
}
