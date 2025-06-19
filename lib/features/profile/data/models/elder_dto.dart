class ElderDto {
  final int id;
  final String name;
  final String lastName;
  final String dni;
  final int age;
  final String gender;
  final String nationality;
  final String insurance;
  final String allergy;
  final String bloodType;

  ElderDto({
    required this.id,
    required this.name,
    required this.lastName,
    required this.dni,
    required this.age,
    required this.gender,
    required this.nationality,
    required this.insurance,
    required this.allergy,
    required this.bloodType,
  });

  factory ElderDto.fromJson(Map<String, dynamic> json) {
    return ElderDto(
      id: json['id'],
      name: json['name'],
      lastName: json['lastName'],
      dni: json['dni'],
      age: json['age'],
      gender: json['gender']['gender'],
      nationality: json['nationality']['nationality'],
      insurance: json['medicalInsurance']['medical'],
      allergy: json['allergy']['allergies'],
      bloodType: json['bloodType']['type'],
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
      "id": 1, // puedes cambiarlo por una propiedad real si la tienes
      "gender": gender
    },
    "bloodType": {
      "id": 5,
      "type": bloodType
    },
    "nationality": {
      "id": 5,
      "nationality": nationality
    },
    "medicalInsurance": {
      "id": 2,
      "medical": insurance
    },
    "allergy": {
      "id": 3,
      "allergies": allergy
    }
  };
}


  ElderDto copyWith({
    String? name,
    String? lastName,
    String? dni,
    int? age,
    String? gender,
    String? nationality,
    String? insurance,
    String? allergy,
    String? bloodType,
  }) {
    return ElderDto(
      id: id,
      name: name ?? this.name,
      lastName: lastName ?? this.lastName,
      dni: dni ?? this.dni,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      nationality: nationality ?? this.nationality,
      insurance: insurance ?? this.insurance,
      allergy: allergy ?? this.allergy,
      bloodType: bloodType ?? this.bloodType,
    );
  }
}
