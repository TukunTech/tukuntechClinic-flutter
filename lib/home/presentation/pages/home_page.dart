import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/auth/presentation/pages/login.dart';
import 'package:tukuntech/features/emergency_numbers/presentation/pages/emergency_numbers_page.dart';
import 'package:tukuntech/features/vital_signs/presentation/pages/vital_signs_page.dart';
import 'package:tukuntech/features/profile/presentation/pages/profile.dart'; // ElderProfilePage
import 'package:tukuntech/features/profile/presentation/blocs/elder_bloc.dart';
import 'package:tukuntech/features/profile/presentation/blocs/elder_event.dart';
import 'package:tukuntech/features/profile/data/datasources/elder_service.dart';
import 'package:tukuntech/home/presentation/pages/reminders.dart';


class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const turquoise = Color(0xFF00A3B2);

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              // Parte superior: Logout y Logo
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        foregroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginScreen()),
                        );
                      },
                      child: const Text('Log out'),
                    ),
                    Image.asset(
                      'assets/logo.png',
                      height: 50,
                    ),
                  ],
                ),
              ),

          // Centro
          Expanded(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'Where do you want to start?',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                  ),
                  const SizedBox(height: 20),
                  _OptionButton(
                    text: 'Vital Signs Panel',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const VitalSignsPage()),
                      );
                    },
                  ),
                  _OptionButton(
                        text: 'Elder Profile',
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => BlocProvider(
                                create: (_) => ElderBloc(ElderService())..add(LoadElder()),
                                child: const ElderProfilePage(),
                              ),
                            ),
                          );
                        },
                      ),
                  _OptionButton(
                    text: 'Emergency numbers',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const EmergencyNumbersPage()),
                      );
                    },
                  ),
                  _OptionButton(
                    text: 'Reminders',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RemindersPage()),
                      );
                    },
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

class _OptionButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const _OptionButton({required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    const turquoise = Color(0xFF00A3B2);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: turquoise,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
            elevation: 3,
            shadowColor: Colors.black54,
          ),
          onPressed: onPressed,
          child: Text(text, style: const TextStyle(fontSize: 16)),
        ),
      ),
    );
  }
}
