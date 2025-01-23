import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import '../models/actuality.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ActualityService {

  String get _base => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8081';
  String get _baseUrl => '$_base/api/actualities';


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
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(responseBody);
      return data.map((json) => Actuality.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load actualities');
    }
  }

  Future<Actuality?> fetchActualityById(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/get_1/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes); // Décode UTF-8
      final Map<String, dynamic> data = json.decode(responseBody);
      return Actuality.fromJson(data);
    } else {
      throw Exception('Failed to load actuality');
    }
  }

  Future<bool> checkIfSubscribed(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/is_subscribed/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      return response.body == 'true';
    } else {
      throw Exception('Failed to check subscription status');
    }
  }

  Future<void> subscribeToEvent(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/subscribe/$id');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      print('Successfully subscribed to the event.');
    } else {
      throw Exception('Failed to subscribe to the event');
    }
  }
}
