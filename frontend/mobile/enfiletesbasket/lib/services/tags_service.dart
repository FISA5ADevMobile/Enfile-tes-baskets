import '../model/tag.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../utils/AppConfig.dart';

class TagsService {

  final String baseUrl = "${AppConfig.baseUrl}/api";

  Future<List<Tag>> fetchClassTags(int courseId, int classId, String token) async {

    final response = await http.get(
      Uri.parse('$baseUrl/courses/$courseId/tags?classId=$classId'),
      headers: {
        'Content-Type': 'application/json; charset=utf-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      print('Fetched Tags: ${response.body}');
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
}
