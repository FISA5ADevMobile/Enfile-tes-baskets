import 'package:enfiletesbasket/services/CourseService.dart';
import 'package:flutter/material.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService _courseService = CourseService();

  Future<int?> fetchCourseId(int userId, int classId) async {
    try {
      return await _courseService.getCourseIdForClass(userId, classId);
    } catch (e) {
      print("Error fetching courseId for classId $classId: $e");
      return null;
    }
  }
}
