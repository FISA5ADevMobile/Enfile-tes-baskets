import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/course.dart';


class CourseService {
  final String baseUrl = "http://10.0.2.2:8081/api/courses";

  /// Récupère les cours associés à l'utilisateur connecté
  Future<List<Course>> fetchMyClasses(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/my-classes'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
      );

      print("Body: ${response.body}");

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Course.fromJson(json)).toList();
      } else {
        throw Exception('Impossible de récupérer mes parcours : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Erreur lors de la récupération de mes parcours : $e");
    }
  }

  /// Inscrit l'utilisateur à une course avec un mot de passe
  Future<String> subscribeToCourseWithPassword(String classPassword, String token) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/subscribe/password?classPassword=$classPassword'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> responseBody = json.decode(response.body);
        return responseBody['message'] ?? 'Inscription au parcours réussie !';
      } else {
        final Map<String, dynamic> errorBody = json.decode(response.body);
        return errorBody['message'] ?? 'Echec lors de l inscription.';
      }
    } catch (e) {
      throw Exception("Erreur lors de l inscription avec mot de passe : $e");
    }
  }

  /// Fetch course ID for a specific class
  Future<int?> getCourseIdForClass(int userId, int classId, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/$userId?classId=$classId'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token', // Ajout du token JWT
        },      );

      if (response.statusCode == 200) {
        return int.tryParse(response.body);
      } else {
        throw Exception('Impossible de récupérer l ID de la course : ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Echec lors de la récupération de l ID de la course pour le parcours $classId: $e");
    }
  }

}
