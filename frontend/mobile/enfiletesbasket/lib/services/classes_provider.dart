import 'package:enfiletesbasket/services/classes_service.dart';
import 'package:flutter/material.dart';

class ClassesProvider extends ChangeNotifier {
  final ClassesService _classesService = ClassesService();

  List<Map<String, dynamic>> _subscribedClasses = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get subscribedClasses => _subscribedClasses;
  bool get isLoading => _isLoading;

  ClassesProvider() {
    fetchSubscribedClasses(1); // Initialisez les données ici
  }

  Future<void> fetchSubscribedClasses(int idUser) async {
    _isLoading = true;
    notifyListeners(); // Notifiez immédiatement
    try {
      final List<Map<String, dynamic>> classes = await _classesService.fetchSubscribedClasses(idUser);
      _subscribedClasses = classes;
    } catch (e) {
      print("Error fetching subscribed classes: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Notifiez après la mise à jour
    }
  }

  /// Join a class with the provided password
  Future<String> joinClass(int idUser, String password) async {
    _isLoading = true;
    notifyListeners();

    String resultMessage;
    try {
      final response = await _classesService.joinClass(idUser, password);
      print("Response: $response");
      print("Status code: ${response.statusCode}");

      if (response.statusCode == 200) {
        print("Status code 200");
        await fetchSubscribedClasses(idUser);
        resultMessage = 'Class joined successfully!';
      } else {
        resultMessage = 'Error joining the class: ${response.statusCode}';
      }
    } catch (e) {
      resultMessage = 'Connection error: $e';
    } finally {
      _isLoading = false;
      notifyListeners();
    }

    // Retourne le message sans appeler notifyListeners ici
    return resultMessage;
  }

}
