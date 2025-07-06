import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/option_item.dart';

class UtilService {
  Future<List<OptionItem>> fetchOptions(String endpoint, String labelKey) async {
    final uri = Uri.parse("https://tukun-tech-platform.onrender.com/api/v1/util/$endpoint");
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body) as List;
      return data.map((e) => OptionItem.fromJson(e, labelKey)).toList();
    } else {
      throw Exception("Failed to load $endpoint options");
    }
  }
}
