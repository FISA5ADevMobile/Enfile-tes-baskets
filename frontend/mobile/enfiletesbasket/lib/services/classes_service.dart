import 'dart:convert';
import 'package:enfiletesbasket/models/course.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class ClassesService {
  String get _base => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8081';
  String get baseUrl => '$_base/classes';

  Future<http.Response> resetTags(int courseId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/$courseId/tags/reset'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
      return response;
    } catch (e) {
      throw Exception("Erreur lors de la participation à la classe : $e");
    }
  }
  Future<int?> getCourseIdForClass(int classId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/courses/user/1?classId=$classId'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token', // Ajout du token JWT
        },
      );

      if (response.statusCode == 200) {
        print("Body getCourseId: ${response.body}");
        return int.tryParse(response.body);
      } else {
        throw Exception('Échec de la récupération de l\'id du cours : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Erreur lors de la récupération de l'id du cours pour classId $classId : $e");
    }
  }
}
