import 'dart:convert';
import 'package:enfiletesbasket/model/course.dart';
import 'package:http/http.dart' as http;

class ClassesService {
  final String baseUrl = "http://10.0.2.2:8081/classes";

  /// Fetch classes subscribed by the user and return a list of Course objects
  Future<List<Course>> fetchSubscribedClasses(int idUser, String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscribed/$idUser'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token', // Format correct
        },
      );
      if (response.statusCode == 200) {
        print("FetchSubscribe: ${response.body}");
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Course.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load subscribed classes");
      }
    } catch (e) {
      throw Exception("Error fetching subscribed classes: $e");
    }
  }


  Future<http.Response> resetTags(int courseId) async {

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/${courseId}/tags/reset'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      return response;
    } catch (e) {
      throw Exception("Error joining class: $e");
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
        throw Exception('Failed to fetch courseId: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception("Error fetching courseId for classId $classId: $e");
    }
  }
}
