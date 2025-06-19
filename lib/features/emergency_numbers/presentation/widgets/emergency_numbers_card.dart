import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../domain/entities/emergency_numbers.dart';
import '../blocs/emergency_numbers_bloc.dart';
import '../blocs/emergency_numbers_event.dart';

class EmergencyContactCard extends StatelessWidget {
  final EmergencyContact contact;

  const EmergencyContactCard({super.key, required this.contact});

  void _makeCall(String phoneNumber) async {
    final Uri url = Uri.parse('tel:$phoneNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'No se pudo iniciar la llamada a $phoneNumber';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF9F1FA),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 3,
            offset: Offset(0, 1),
          )
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        title: Text(contact.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(contact.phone),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => _makeCall(contact.phone),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00A3B2),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: const Text('Call'),
            ),
            const SizedBox(width: 8),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                context.read<EmergencyNumbersBloc>().add(DeleteEmergencyContact(contact.id));
              },
            ),
          ],
        ),
      ),
    );
  }
}
