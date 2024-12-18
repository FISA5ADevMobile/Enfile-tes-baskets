import 'dart:convert';
import 'package:http/http.dart' as http;

class TagsService {
  final String baseUrl = "http://10.0.2.2:8080";

  Future<List<Map<String, dynamic>>> fetchClassTags(int classId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tags/class/$classId'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch class tags');
    }
  }

  Future<List<Map<String, dynamic>>> fetchCourseTags(int courseId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tags/course/$courseId'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    } else {
      throw Exception('Failed to fetch course tags');
    }
  }

  Future<void> resetTags(int courseId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/classes/$courseId/tags/reset'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to reset tags');
    }
  }

  Future<String> fetchTagDescription(String tagId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tags/$tagId/description'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      return response.body; // Assuming plain text description
    } else {
      throw Exception('Failed to fetch tag description');
    }
  }

  Future<void> validateTag(int classId, int courseId, String tagId, int userId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/classes/$classId/courseId/$courseId/tags/$tagId/validate?userId=$userId'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to validate tag');
    }
  }
}
