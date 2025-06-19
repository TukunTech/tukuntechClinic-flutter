import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/emergency_numbers_dto.dart';

class EmergencyNumbersService {
  final String getUrl =
      'https://tukun-tech-platform.onrender.com/api/v1/emergencyNumbers/emergencyNumbers';

  final String postUrl =
      'https://tukun-tech-platform.onrender.com/api/v1/emergencyNumbers';


  Future<List<EmergencyContactDto>> fetchEmergencyContacts() async {
    final response = await http.get(Uri.parse(getUrl));

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => EmergencyContactDto.fromJson(json))
          .toList();
    } else {
      throw Exception('Failed to load emergency contacts');
    }
  }


  Future<void> addEmergencyContact(EmergencyContactDto dto) async {
    final response = await http.post(
      Uri.parse(postUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
    );

    if (response.statusCode != 201 && response.statusCode != 200) {
      throw Exception('Failed to add emergency contact');
    }
  }

  Future<void> deleteEmergencyContact(int id) async {
    final url = 'https://tukun-tech-platform.onrender.com/api/v1/emergencyNumbers/$id';

    final response = await http.delete(Uri.parse(url));
    if (response.statusCode != 200 && response.statusCode != 204) {
      throw Exception('Failed to delete emergency contact');
    }
  }
}

