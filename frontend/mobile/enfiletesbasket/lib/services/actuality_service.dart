import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/actuality.dart';

class ActualityService {
  static const String _baseUrl = 'http://localhost:8080/api/activities'; // À adapter selon votre backend

  Future<List<Actuality>> fetchActivities() async {
    final response = await http.get(Uri.parse(_baseUrl));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Actuality.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load activities');
    }
  }
}
