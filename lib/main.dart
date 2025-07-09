import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/features/auth/presentation/blocs/auth_bloc.dart';
import 'package:tukuntech/features/auth/presentation/blocs/register_bloc.dart';
import 'package:tukuntech/features/auth/presentation/pages/login.dart';
import 'package:tukuntech/features/medicationsTaken/blocs/medication_taken_bloc.dart';
import 'package:tukuntech/features/auth/data/datasources/auth_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => MedicationTakenBloc()),
        BlocProvider(create: (_) => RegisterBloc(AuthService())),
        BlocProvider(create: (_) => AuthBloc(AuthService())),
      ],
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
