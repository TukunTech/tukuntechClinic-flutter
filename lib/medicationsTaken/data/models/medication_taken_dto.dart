import 'package:tukuntech/home/domain/entities/TimeToTake.dart';
import 'package:tukuntech/medicationsTaken/domain/entities/MedicationTaken.dart';

class MedicationTakenDto {
  final int id;
  final String name;
  final String dosage;
  final DateTime takenAt;

  const MedicationTakenDto({
    required this.id,
    required this.name,
    required this.dosage,
    required this.takenAt,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'dosage': dosage,
      'takenAt': takenAt.toIso8601String(),
    };
  }

  factory MedicationTakenDto.fromJson(Map<String, dynamic> json) {
    return MedicationTakenDto(
      id: json['id'] as int,
      name: json['name'] as String,
      dosage: json['dosage'] as String,
      takenAt: DateTime.parse(json['takenAt'] as String),
    );
  }

MedicationTaken toDomain() {
  return MedicationTaken(
    id: id,
    medicineName: name,
    dosage: dosage,
    status: [], // puedes ajustar esto si es necesario
    timeToTake: [
      TimeToTake(
        hour: takenAt.hour,
        minute: takenAt.minute,
        second: takenAt.second,
        nano: takenAt.microsecond * 1000,
      )
    ],
  );
}

factory MedicationTakenDto.fromDomain(MedicationTaken medication) {
  return MedicationTakenDto(
    id: medication.id,
    name: medication.medicineName.isNotEmpty ? medication.medicineName : 'Unnamed',
    dosage: medication.dosage.isNotEmpty ? medication.dosage : 'Sin dosis',
    takenAt: DateTime.now(), // o usa la hora de la medicina
  );
}


factory MedicationTakenDto.fromMap(Map<String, dynamic> map) {
    return MedicationTakenDto(
      id: map['id'] as int,
      name: map['medicineName'] as String,
      dosage: map['dosage'] as String,
      takenAt: DateTime.parse(map['takenAt'] as String),
    );
  }

  Map<String, dynamic> toMap() {
  return {
    'medicineName': name,
    'dosage': dosage,
    'takenAt': takenAt.toIso8601String(),
  };
}

}