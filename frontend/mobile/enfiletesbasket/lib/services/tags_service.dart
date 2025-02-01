import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/tag.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TagsService {

  String get _base => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8081';
  String get baseUrl => '$_base/api';

  Future<List<Tag>> fetchClassTags(int courseId, String token) async {
    print("Je fetch les tags de la course: $courseId");
    final response = await http.get(
      Uri.parse('$baseUrl/courses/$courseId/tags'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Voici les tags que je récupère : ${response.body}');
      return (data as List).map((e) => Tag.fromJson(e)).toList();
    } else {
      throw Exception('Impossible de récupérer les balises');
    }
  }


  /// Réinitialise toutes les balises à non validées
  Future<void> resetTags(int courseId, String token) async {
    final response = await http.put(
      Uri.parse('$baseUrl/validations/$courseId/reset'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Impossible de réinitialiser les balises');
    }
  }

  /// Valide une balise spécifique
  Future<void> validateTag(int courseId, int tagId, String token) async {
    final response = await http.post(
      Uri.parse('$baseUrl/validations/$courseId/tags/$tagId/validate'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Impossible de valider la balise');
    }
  }
  Future<Tag> fetchTagById(int tagId, String token) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tags/$tagId'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Tag.fromJson(data);
    } else {
      throw Exception('Impossible de récupérer les détails de la balise');
    }
  }

}
