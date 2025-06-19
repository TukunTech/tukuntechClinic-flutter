import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/vital_sign_dto.dart';

class VitalSignsService {
  final String _baseUrl = 'https://tukun-tech-platform.onrender.com/api/v1/elder-bed';

  Future<VitalSignDto> fetchLatestVitalSigns() async {
    final response = await http.get(Uri.parse(_baseUrl));
    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      if (jsonList.isNotEmpty) {
        return VitalSignDto.fromJson(jsonList.first);
      } else {
        throw Exception('Empty list');
      }
    } else {
      throw Exception('Error ${response.statusCode}');
    }
  }
}
