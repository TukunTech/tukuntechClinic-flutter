import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/models/elder_dto.dart';
import '../blocs/elder_bloc.dart';
import '../blocs/elder_event.dart';
import '../blocs/elder_state.dart';

class ElderProfilePage extends StatefulWidget {
  const ElderProfilePage({super.key});

  @override
  State<ElderProfilePage> createState() => _ElderProfilePageState();
}

class _ElderProfilePageState extends State<ElderProfilePage> {
  final _formKey = GlobalKey<FormState>();
  late ElderDto _elder;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<ElderBloc>().add(LoadElder());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      body: BlocConsumer<ElderBloc, ElderState>(
        listener: (context, state) {
          if (state is ElderSaved) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Saved")),
            );
          } else if (state is ElderError) {
            setState(() => _isSaving = false);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is ElderLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ElderLoaded) {
            _elder = state.elder;
            return SafeArea(
              child: Column(
                children: [
                  // Botón "return" personalizado
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        ElevatedButton(
                          onPressed: () => Navigator.pop(context),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00BFCB),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 4,
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          child: const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(Icons.arrow_back, color: Colors.white),
                              SizedBox(width: 4),
                              Text("return", style: TextStyle(color: Colors.white)),
                            ],
                          ),
                        ),
                        const Spacer(),
                        Image.asset(
                          'assets/logo.png', // Ajusta la ruta si usas un logo
                          height: 30,
                        ),
                      ],
                    ),
                  ),
                  const Text(
                    "Elder Profile",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                        elevation: 4,
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                ..._buildTextFields(),
                                const SizedBox(height: 20),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: const Color(0xFF00BFCB),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                    ),
                                    onPressed: _isSaving
                                        ? null
                                        : () {
                                            setState(() => _isSaving = true);
                                            context.read<ElderBloc>().add(SaveElder(_elder));
                                          },
                                    child: _isSaving
                                        ? const SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                        : const Text("Save", style: TextStyle(color: Colors.white)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else if (state is ElderSaved) {
            context.read<ElderBloc>().add(LoadElder());
            return const Center(child: CircularProgressIndicator());
          } else if (state is ElderError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _input("Name", _elder.name, (v) => _elder = _elder.copyWith(name: v)),
      _input("Last Name", _elder.lastName, (v) => _elder = _elder.copyWith(lastName: v)),
      _input("DNI", _elder.dni, (v) => _elder = _elder.copyWith(dni: v)),
      _input("Gender", _elder.gender, (v) => _elder = _elder.copyWith(gender: v)),
      _input("Age", _elder.age.toString(), (v) {
        final parsed = int.tryParse(v);
        if (parsed != null) _elder = _elder.copyWith(age: parsed);
      }),
      _input("Nacionalidad", _elder.nationality, (v) => _elder = _elder.copyWith(nationality: v)),
      _input("N° Póliza", "12345678", (_) {}), // campo ficticio
      _input("Seguro", _elder.insurance, (v) => _elder = _elder.copyWith(insurance: v)),
      _input("Alergias", _elder.allergy, (v) => _elder = _elder.copyWith(allergy: v)),
      _input("Grupo Sanguíneo", _elder.bloodType, (v) => _elder = _elder.copyWith(bloodType: v)),
    ];
  }

  Widget _input(String label, String initialValue, Function(String) onChanged) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          hintText: "$label:",
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
