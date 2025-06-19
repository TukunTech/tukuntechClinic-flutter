import 'package:tukuntech/features/pendingMedications/domain/entities/Status.dart';
import 'package:tukuntech/features/pendingMedications/domain/entities/TimeToTake.dart';

class MedicationTaken{
  final int id;
  final String medicineName;
  final String dosage;
  final List<Status> status;
  final List<TimeToTake> timeToTake;

  const MedicationTaken({
    required this.id,
    required this.medicineName,
    required this.dosage,
    required this.status,
    required this.timeToTake
  });
}