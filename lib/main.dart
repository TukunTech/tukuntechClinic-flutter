import 'package:flutter/material.dart';
import 'package:tukuntech/features/auth/presentation/pages/login.dart';
import 'features/medicationsTaken/blocs/medication_taken_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => MedicationTakenBloc(),
      child: MaterialApp(
        title: 'Tukun Tech',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
