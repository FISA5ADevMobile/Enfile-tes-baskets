import 'package:enfiletesbasket/services/course_service.dart';
import 'package:flutter/material.dart';
import '../models/course.dart';

class CourseProvider extends ChangeNotifier {
  final CourseService _courseService = CourseService();

  List<Course> _myCourses = [];
  List<Course> get myCourses => _myCourses;

  /// Récupère les cours associés à l'utilisateur connecté
  Future<void> fetchMyClasses(String token) async {
    try {
      _myCourses = await _courseService.fetchMyClasses(token);
      notifyListeners();
    } catch (e) {
      print("Erreur lors de la récupération du parcours : $e");
      throw Exception("Echec lors de la récupération de mes parcours");
    }
  }

  /// Inscrit l'utilisateur à une classe avec un mot de passe
  Future<String> subscribeToCourseWithPassword(String classPassword, String token) async {
    try {
      final String responseMessage = await _courseService.subscribeToCourseWithPassword(classPassword, token);
      await fetchMyClasses(token); // Rafraîchir les cours après inscription
      notifyListeners();
      return responseMessage;
    } catch (e) {
      print("Erreur lors de l'inscription au parcours avec mot de passe : $e");
      return "Impossible de s'inscrire au parcours.";
    }
  }
}
