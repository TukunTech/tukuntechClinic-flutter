import 'package:tukuntech/features/medicationsTaken/data/datasources/medication_taken_dao.dart';
import 'package:tukuntech/features/medicationsTaken/data/models/medication_taken_dto.dart';
import 'package:tukuntech/features/medicationsTaken/domain/entities/medication_taken.dart';

class MedicationTakenRepository {
  final MedicationTakenDao _dao = MedicationTakenDao();

  Future<void> insertMedicationTaken(MedicationTaken medicationTaken) async {
   _dao.insertMedicationTaken(MedicationTakenDto.fromDomain(medicationTaken));
  }

  Future<void> deleteMedicationTaken(int id) async {
    await _dao.deleteMedicationTaken(id);
  }

  Future<List<MedicationTaken>> fetchAll() async {
    final dtos = await _dao.fetchAll();
    return dtos.map((dto) => dto.toDomain()).toList();
  }
}