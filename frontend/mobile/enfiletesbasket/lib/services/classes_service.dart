import 'dart:convert';
import 'package:enfiletesbasket/model/Course.dart';
import 'package:http/http.dart' as http;

class ClassesService {
  final String baseUrl = "http://10.0.2.2:8081/classes";

  /// Fetch classes subscribed by the user and return a list of Course objects
  Future<List<Course>> fetchSubscribedClasses(int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscribed/$idUser'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => Course.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load subscribed classes");
      }
    } catch (e) {
      throw Exception("Error fetching subscribed classes: $e");
    }
  }

  /// Join a class with the provided password
  Future<http.Response> joinClass(int idUser, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/join/$idUser?password=$password'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );
      return response;
    } catch (e) {
      throw Exception("Error joining class: $e");
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
  Future<int?> getCourseIdForClass(int classId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/courses/user/1?classId=$classId'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
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
