import 'package:enfiletesbasket/model/Course.dart';
import 'package:flutter/material.dart';
import '../services/classes_service.dart';

class ClassesProvider extends ChangeNotifier {
  final ClassesService _classesService = ClassesService();

  List<Course> _subscribedClasses = [];

  List<Course> get subscribedClasses => _subscribedClasses;

  Future<void> fetchSubscribedClasses(int idUser, String token) async {
    try {
      _subscribedClasses = await _classesService.fetchSubscribedClasses(idUser,token);
      notifyListeners(); // Notifier les consommateurs que les données ont changé
    } catch (e) {
      print("Error fetching subscribed classes: $e");
    }
  }

  Future<String> joinClass(int idUser, String password, String token) async {
    String resultMessage;
    try {
      final response = await _classesService.joinClass(idUser, password, token);

      if (response.statusCode == 200) {
        await fetchSubscribedClasses(idUser, token); // Rafraîchir la liste des classes
        resultMessage = 'Class joined successfully!';
      } else {
        resultMessage = 'Error joining the class: ${response.statusCode}';
      }
    } catch (e) {
      resultMessage = 'Connection error: $e';
    }

    return resultMessage;
  }

  Future<int?> getCourseId(int classId, String token) async {
    try {
      return await _classesService.getCourseIdForClass(classId, token);
    } catch (e) {
      print("Error fetching courseId for classId $classId: $e");
      return null;
    }
  }
}
