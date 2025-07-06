import 'package:tukuntech/features/medicationsTaken/domain/entities/medication_taken.dart';

abstract class MedicationTakenState {
  const MedicationTakenState();

}

class InitialMedicationTakenState extends MedicationTakenState {}

class LoadedMedicationTakenState extends MedicationTakenState {
  final List<MedicationTaken> medicationTaken;

  const LoadedMedicationTakenState({required this.medicationTaken});
}