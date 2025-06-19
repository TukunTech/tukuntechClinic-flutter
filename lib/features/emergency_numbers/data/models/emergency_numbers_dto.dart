class EmergencyContactDto {
  final int id;
  final String number;
  final String contactName;

  EmergencyContactDto({
    required this.id,
    required this.number,
    required this.contactName,
  });

  factory EmergencyContactDto.fromJson(Map<String, dynamic> json) {
    return EmergencyContactDto(
      id: json['id'],
      number: json['number'],
      contactName: json['contactName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'number': number,
      'contactName': contactName,
    };
  }
}
