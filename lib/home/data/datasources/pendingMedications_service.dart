import 'dart:convert';
import 'dart:io';

import 'package:tukuntech/home/data/models/pendingMedications_dto.dart';
import 'package:tukuntech/home/domain/entities/pendingMedications.dart';
import 'package:http/http.dart' as http;

class PendingMedicationsService{
  Future<List<PendingMedications>> getPendingMedications() async {
  final Uri uri = Uri.parse('https://tukun-tech-platform.onrender.com/api/v1/pendingMedicine/pendingMedicines');
  final response = await http.get(uri);

  if (response.statusCode == HttpStatus.ok) {
    try {
      final body = jsonDecode(response.body);

      final List<dynamic> data = body is List
          ? body
          : (body['data'] ?? []);

      return data
          .map((e) => PendingMedicationsDto.fromJson(e).toDomain())
          .toList();
    } catch (e) {
      print('Error al parsear respuesta: $e');
    }
  } else {
    print('Error HTTP: ${response.statusCode}');
  }

  return [];
}
}