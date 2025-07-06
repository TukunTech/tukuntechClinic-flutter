import 'package:tukuntech/features/medicationsTaken/domain/entities/medication_taken.dart';

abstract class MedicationTakenEvent {
  const MedicationTakenEvent();
}
class AddMedicationTakenEvent extends MedicationTakenEvent {
  final MedicationTaken medicationTaken;
  const AddMedicationTakenEvent({required this.medicationTaken});
}

class RemoveMedicationTakenEvent extends MedicationTakenEvent {
  final int id;
  const RemoveMedicationTakenEvent({required this.id});
}
class GetAllMedicationTakenEvent extends MedicationTakenEvent {}