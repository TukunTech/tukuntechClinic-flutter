class ElderDto {
  final int id;
  final String name;
  final String lastName;
  final String dni;

  ElderDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.dni,
  });

  factory ElderDto.fromJson(Map<String, dynamic> json) {
    return ElderDto(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      dni: json['dni'],
    );
  }

  @override
  String toString() => '$name $lastName';
}

class VitalSignDto {
  final int hr;
  final String nipb;
  final int sp02;
  final double temp;
  final ElderDto elder;

  VitalSignDto({
    required this.hr,
    required this.nipb,
    required this.sp02,
    required this.temp,
    required this.elder,
  });

  factory VitalSignDto.fromJson(Map<String, dynamic> json) {
    return VitalSignDto(
      hr: json['hr'],
      nipb: json['nipb'],
      sp02: json['sp02'],
      temp: (json['temp'] as num).toDouble(),
      elder: ElderDto.fromJson(json['elder']),
    );
  }
}
