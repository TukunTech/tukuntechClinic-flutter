import 'package:tukuntech/features/pendingMedications/domain/entities/PendingMedications.dart';
import 'package:tukuntech/features/pendingMedications/domain/entities/Status.dart';
import 'package:tukuntech/features/pendingMedications/domain/entities/TimeToTake.dart';

class PendingMedicationsDto{
  final int id;
  final String medicineName;
  final String dosage;
  final List<StatusDto> status;
  final List<TimeToTakeDto> timeToTake;

  const PendingMedicationsDto({
    required this.id,
    required this.medicineName,
    required this.dosage,
    required this.status,
    required this.timeToTake
  });

 factory PendingMedicationsDto.fromJson(Map<String, dynamic> json) {
  return PendingMedicationsDto(
    id: json['id'] ?? 0,
    medicineName: json['medicineName'] ?? '',
    dosage: json['dosage'] ?? '',
    status: (json['status'] as List?)?.map((e) => StatusDto.fromJson(e)).toList() ?? [],
    timeToTake: (json['timeToTake'] as List?)?.map((e) => TimeToTakeDto.fromJson(e)).toList() ?? [],

  );
}


  PendingMedications toDomain(){
    return PendingMedications(
      id: id,
      medicineName: medicineName,
      dosage: dosage,
      status: status.map((e) => e.toDomain()).toList(),
      timeToTake: timeToTake.map((e) => e.toDomain()).toList()
    );
  }

}

class StatusDto{
  final int id;
  final String status;

  const StatusDto({
    required this.id,
    required this.status

  });
  factory StatusDto.fromJson(Map<String, dynamic> json){
    return StatusDto(id: json['id'], status: json['status']);
  } 

  Status toDomain(){
    return Status(id: id, status: status);
  }
  
}

class TimeToTakeDto{
  final int hour;
  final int minute;
  final int second;
  final int nano;

  const TimeToTakeDto({
    required this.hour,
    required this.minute,
    required this.second,
    required this.nano,
    });

  factory TimeToTakeDto.fromJson(Map<String, dynamic> json){
    return TimeToTakeDto(hour: json['hour'], minute: json['minute'], second: json['second'], nano: json['nano']);
  }

  TimeToTake toDomain(){
    return TimeToTake(hour: hour, minute: minute, second: second, nano: nano);
  }
}
