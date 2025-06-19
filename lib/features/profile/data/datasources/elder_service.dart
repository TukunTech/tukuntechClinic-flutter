import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/elder_dto.dart';

class ElderService {
  final String _url = 'https://tukun-tech-platform.onrender.com/api/v1/elder-bed';

  Future<ElderDto> fetchElder() async {
    final response = await http.get(Uri.parse(_url));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body)[0];
      return ElderDto.fromJson(data['elder']);
    } else {
      throw Exception("Failed to fetch elder data");
    }
  }

  Future<void> updateElder(ElderDto elder) async {
  final uri = Uri.parse('https://tukun-tech-platform.onrender.com/api/v1/elders/${elder.id}');

  final response = await http.put(
    uri,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(elder.toJson()),
  );

  if (response.statusCode != 200) {
    print("ERROR: ${response.statusCode} - ${response.body}");
    throw Exception("Failed to update elder");
  }
}

}
