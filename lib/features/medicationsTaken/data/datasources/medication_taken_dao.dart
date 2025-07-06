import 'package:tukuntech/features/medicationsTaken/data/datasources/app_database.dart';
import 'package:tukuntech/features/medicationsTaken/data/models/medication_taken_dto.dart';

class MedicationTakenDao{

Future<void> insertMedicationTaken(MedicationTakenDto medicationTaken) async{
  final db = await AppDatabase().database;
  db.insert('medicationsTaken', medicationTaken.toMap());
}

Future<void> deleteMedicationTaken(int id) async{
  final db = await AppDatabase().database;
  db.delete('medicationsTaken', where: 'id = ?', whereArgs: [id]);
}

Future<List<MedicationTakenDto>> fetchAll() async {
  final db = await AppDatabase().database;
  final maps = await db.query('medicationsTaken');
  return maps.map((e) => MedicationTakenDto.fromMap(e)).toList();
}



}