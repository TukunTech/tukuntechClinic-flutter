import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/core/widgets/base_screen.dart';
import '../blocs/emergency_numbers_bloc.dart';
import '../blocs/emergency_numbers_event.dart';
import '../blocs/emergency_numbers_state.dart';
import '../widgets/emergency_numbers_card.dart';
import '../widgets/emergency_numbers_form.dart';
import '../../data/datasources/emergency_numbers_service.dart';

class EmergencyNumbersPage extends StatelessWidget {
  const EmergencyNumbersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EmergencyNumbersBloc(service: EmergencyNumbersService())
        ..add(LoadEmergencyContacts()),
      child: BaseScreen(
        currentIndex: 4,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: BlocBuilder<EmergencyNumbersBloc, EmergencyNumbersState>(
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }

              return SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildTopBar(context),
                      const SizedBox(height: 12),
                      _SectionTitle(title: 'Family Contact'),
                      const SizedBox(height: 8),
                      ...state.familyContacts.map((c) => EmergencyContactCard(contact: c)),
                      const SizedBox(height: 16),
                      _SectionTitle(title: 'Emergency Numbers'),
                      const SizedBox(height: 8),
                      ...state.emergencyServices.map((c) => EmergencyContactCard(contact: c)),
                      const SizedBox(height: 24),
                      const EmergencyContactForm(),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ElevatedButton.icon(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, size: 20),
          label: const Text('return', style: TextStyle(fontSize: 14)),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00A3B2),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            elevation: 4,
            shadowColor: Colors.black45,
          ),
        ),
        Image.asset('assets/logo.png', height: 40),
      ],
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: const Color(0xFF00A3B2),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Text(title,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
      ),
    );
  }
}
