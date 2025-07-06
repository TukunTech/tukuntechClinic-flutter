class ElderDto {
  final int id;
  final String name;
  final String lastName;
  final String dni;
  final int age;

  final int genderId;
  final String gender;

  final int bloodTypeId;
  final String bloodType;

  final int nationalityId;
  final String nationality;

  final int insuranceId;
  final String insurance;

  final int allergyId;
  final String allergy;

  ElderDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.dni,
    required this.age,
    required this.genderId,
    required this.gender,
    required this.bloodTypeId,
    required this.bloodType,
    required this.nationalityId,
    required this.nationality,
    required this.insuranceId,
    required this.insurance,
    required this.allergyId,
    required this.allergy,
  });

  factory ElderDto.fromJson(Map<String, dynamic> json) {
    return ElderDto(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      dni: json['dni'],
      age: json['age'],
      genderId: json['gender']['id'],
      gender: json['gender']['gender'],
      bloodTypeId: json['bloodType']['id'],
      bloodType: json['bloodType']['type'],
      nationalityId: json['nationality']['id'],
      nationality: json['nationality']['nationality'],
      insuranceId: json['medicalInsurance']['id'],
      insurance: json['medicalInsurance']['medical'],
      allergyId: json['allergy']['id'],
      allergy: json['allergy']['allergies'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "lastName": lastName,
      "dni": dni,
      "age": age,
      "gender": {
        "id": genderId,
        "gender": gender
      },
      "bloodType": {
        "id": bloodTypeId,
        "type": bloodType
      },
      "nationality": {
        "id": nationalityId,
        "nationality": nationality
      },
      "medicalInsurance": {
        "id": insuranceId,
        "medical": insurance
      },
      "allergy": {
        "id": allergyId,
        "allergies": allergy
      }
    };
  }

  ElderDto copyWith({
    String? name,
    String? lastName,
    String? dni,
    int? age,
    int? genderId,
    String? gender,
    int? bloodTypeId,
    String? bloodType,
    int? nationalityId,
    String? nationality,
    int? insuranceId,
    String? insurance,
    int? allergyId,
    String? allergy,
  }) {
    return ElderDto(
      id: id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dni: dni ?? this.dni,
      age: age ?? this.age,
      genderId: genderId ?? this.genderId,
      gender: gender ?? this.gender,
      bloodTypeId: bloodTypeId ?? this.bloodTypeId,
      bloodType: bloodType ?? this.bloodType,
      nationalityId: nationalityId ?? this.nationalityId,
      nationality: nationality ?? this.nationality,
      insuranceId: insuranceId ?? this.insuranceId,
      insurance: insurance ?? this.insurance,
      allergyId: allergyId ?? this.allergyId,
      allergy: allergy ?? this.allergy,
    );
  }
}

