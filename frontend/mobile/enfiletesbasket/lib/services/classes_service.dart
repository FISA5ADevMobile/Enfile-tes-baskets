import 'dart:convert';
import 'package:http/http.dart' as http;

class ClassesService {
  final String baseUrl = "http://10.0.2.2:8081/classes";

  /// Fetch classes subscribed by the user
  Future<List<Map<String, dynamic>>> fetchSubscribedClasses(int idUser) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/subscribed/$idUser'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        return List<Map<String, dynamic>>.from(json.decode(response.body));
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
    /*if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tag successfully reinit')),
      );
      fetchTags();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reinit tags')),
      );
    }*/
  }
}
