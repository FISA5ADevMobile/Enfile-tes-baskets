import 'package:http/http.dart' as http;

class CourseService {
  final String baseUrl = "http://10.0.2.2:8081/courses";

  /// Fetch course ID for a specific class
  Future<int?> getCourseIdForClass(int userId, int classId) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/user/$userId?classId=$classId'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

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
