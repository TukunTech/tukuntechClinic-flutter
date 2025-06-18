import 'dart:convert';
import 'dart:io';

import 'package:tukuntech/features/data/models/pendingMedications_dto.dart';
import 'package:tukuntech/home/domain/entities/pendingMedications.dart';
import 'package:http/http.dart' as http;

class PendingMedicationsService{
  Future<List<PendingMedications>> getPendingMedications() async {
    final Uri uri = Uri.parse('https://tukun-tech-platform.onrender.com/api/v1/pendingMedicine/pendingMedicines');
    final response = await http.get(uri);

    if (response.statusCode == HttpStatus.ok) {
      List maps = jsonDecode(response.body);
      return maps.map((e) => PendingMedicationsDto.fromJson(e).toDomain()).toList();
    }
    return [];
  }

}