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
        throw Exception('Failed to fetch my classes: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching my classes: $e");
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
        return responseBody['message'] ?? 'Successfully subscribed to the course!';
      } else {
        final Map<String, dynamic> errorBody = json.decode(response.body);
        return errorBody['message'] ?? 'Failed to subscribe to the course.';
      }
    } catch (e) {
      throw Exception("Error subscribing to course with password: $e");
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
        throw Exception('Failed to fetch courseId: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching courseId for classId $classId: $e");
    }
  }

}
