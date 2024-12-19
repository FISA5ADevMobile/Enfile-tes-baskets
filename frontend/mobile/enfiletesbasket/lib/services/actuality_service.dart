import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/actuality.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActualityService {
  static const String _baseUrl = 'http://10.0.2.2:8081/api/actualities';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<Actuality>> fetchAllActualities() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/get_all');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Actuality.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load actualities');
    }
  }
}
