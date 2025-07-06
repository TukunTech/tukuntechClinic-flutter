import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tukuntech/core/widgets/base_screen.dart';
import '../../data/models/elder_dto.dart';
import '../../data/models/option_item.dart';
import '../../data/datasources/util_service.dart';
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

  final UtilService _utilService = UtilService();

  List<OptionItem> genders = [];
  List<OptionItem> bloodTypes = [];
  List<OptionItem> nationalities = [];
  List<OptionItem> insurances = [];
  List<OptionItem> allergies = [];

  bool listsLoaded = false;

  @override
  void initState() {
    super.initState();

    _loadDropdownOptions();

    Future.microtask(() {
      context.read<ElderBloc>().add(LoadElder());
    });
  }

  void _loadDropdownOptions() async {
    try {
      final results = await Future.wait([
        _utilService.fetchOptions("listGender", "gender"),
        _utilService.fetchOptions("listBlood", "type"),
        _utilService.fetchOptions("listNationality", "nationality"),
        _utilService.fetchOptions("listMedicalInsurance", "medical"),
        _utilService.fetchOptions("listAllergy", "allergies"),
      ]);

      setState(() {
        genders = results[0];
        bloodTypes = results[1];
        nationalities = results[2];
        insurances = results[3];
        allergies = results[4];
        listsLoaded = true;
      });
    } catch (e) {
      print("ERROR AL CARGAR DROPDOWNS: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Error loading dropdown values")),
      );
    }
  }

  bool _listsAreReady() {
    return listsLoaded &&
        genders.isNotEmpty &&
        bloodTypes.isNotEmpty &&
        nationalities.isNotEmpty &&
        insurances.isNotEmpty &&
        allergies.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      currentIndex: 3,
      child: BlocConsumer<ElderBloc, ElderState>(
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
          if (state is ElderLoading || !_listsAreReady()) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ElderLoaded) {
            _elder = state.elder;
            return buildForm();
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

  Widget buildForm() {
    return Column(
      children: [
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
                'assets/logo.png',
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
    );
  }

  List<Widget> _buildTextFields() {
    return [
      _input("Name", _elder.name, (v) => _elder = _elder.copyWith(name: v)),
      _input("Last Name", _elder.lastName, (v) => _elder = _elder.copyWith(lastName: v)),
      _input("DNI", _elder.dni, (v) => _elder = _elder.copyWith(dni: v)),
      _dropdown("Gender", _elder.gender, _elder.genderId, genders, (item) {
        _elder = _elder.copyWith(gender: item.label, genderId: item.id);
      }),
      _input("Age", _elder.age.toString(), (v) {
        final parsed = int.tryParse(v);
        if (parsed != null) _elder = _elder.copyWith(age: parsed);
      }),
      _dropdown("Nacionalidad", _elder.nationality, _elder.nationalityId, nationalities, (item) {
        _elder = _elder.copyWith(nationality: item.label, nationalityId: item.id);
      }),
      _input("N° Póliza", "12345678", (_) {}),
      _dropdown("Seguro", _elder.insurance, _elder.insuranceId, insurances, (item) {
        _elder = _elder.copyWith(insurance: item.label, insuranceId: item.id);
      }),
      _dropdown("Alergias", _elder.allergy, _elder.allergyId, allergies, (item) {
        _elder = _elder.copyWith(allergy: item.label, allergyId: item.id);
      }),
      _dropdown("Grupo Sanguíneo", _elder.bloodType, _elder.bloodTypeId, bloodTypes, (item) {
        _elder = _elder.copyWith(bloodType: item.label, bloodTypeId: item.id);
      }),
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

  Widget _dropdown(
    String label,
    String selectedLabel,
    int selectedId,
    List<OptionItem> options,
    Function(OptionItem) onChanged,
  ) {
    final selected = options.firstWhere(
      (opt) => opt.id == selectedId || opt.label.toLowerCase() == selectedLabel.toLowerCase(),
      orElse: () => options.first,
    );

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: DropdownButtonFormField<OptionItem>(
        value: selected,
        items: options.map((item) {
          return DropdownMenuItem<OptionItem>(
            value: item,
            child: Text(item.label),
          );
        }).toList(),
        onChanged: (item) {
          if (item != null) onChanged(item);
        },
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
      ),
    );
  }
}
 
