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
}

class StatusDto{
  final int id;
  final String status;

  const StatusDto({
    required this.id,
    required this.status

  });
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
}
