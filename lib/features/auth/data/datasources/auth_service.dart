import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tukuntech/features/auth/data/models/register_dto.dart';
import '../models/login_dto.dart';

class AuthService {
  final String _baseUrl = 'https://tukun-tech-platform.onrender.com/api/v1/auth/login';

  Future<bool> login(LoginDTO loginDTO) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(loginDTO.toJson()),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
    Future<bool> register(RegisterDTO dto) async {
    final url = Uri.parse('https://tukun-tech-platform.onrender.com/api/v1/auth/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(dto.toJson()),
    );

    return response.statusCode == 201 || response.statusCode == 200;
  }

}
