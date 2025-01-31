import 'package:flutter/material.dart';
import '../screens/tag_details_page.dart';
import '../services/tags_service.dart';
import '../models/tag.dart';

class TagsProvider extends ChangeNotifier {
  final TagsService _tagsService = TagsService();
  Tag? _currentTag;
  Tag? get currentTag => _currentTag;

  List<Tag> _tags = [];
  String _filter = "Toutes";
  bool _isCameraActive = false;

  List<Tag> get tags => _tags;

  String get filter => _filter;

  List<Tag> get filteredTags {
    if (_filter == "Validées") {
      return _tags.where((tag) => tag.validated).toList();
    } else if (_filter == "Non Validées") {
      return _tags.where((tag) => !tag.validated).toList();
    }
    return _tags;
  }

  bool get isCameraActive => _isCameraActive;

  /// Met à jour le filtre et notifie les consommateurs
  void updateFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void onTagScanned(BuildContext context, int tagId, int courseId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TagDetailsPage(tagId: tagId, courseId: courseId),
      ),
    );
  }



  /// Active ou désactive la caméra
  void toggleCamera() {
    _isCameraActive = !_isCameraActive;
    notifyListeners();
  }

  /// Récupère toutes les balises pour une classe et un cours
  Future<void> fetchTags( int classId, String token) async {
    try {
      _tags = await _tagsService.fetchClassTags(classId, token);
      print('Balise récupérée dans le provider : $_tags');
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la récupération des balises : $e');
    }
  }

  /// Réinitialise l'état des balises pour un cours
  Future<void> resetTags(int courseId,String token) async {
    try {
      await _tagsService.resetTags(courseId,token);
      for (var tag in _tags) {
        tag.validated = false;
      }
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la réinitialisation : $e');
    }
  }

  /// Valide une balise spécifique
  Future<void> validateTag(int courseId, int tagId, String token) async {
    try {
      await _tagsService.validateTag(courseId, tagId, token);
      final tag = _tags.firstWhere(
            (tag) => tag.id == tagId,
        orElse: () => Tag(
          id: tagId,
          name: "Balise inconnue",
          description: "Balise non reconnue",
          validated: false,
          xPos: 0.0,
          yPos: 0.0,
        ),
      );
      if (tag.id != -1) {
        tag.validated = true; // Met à jour comme validée
      }
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la validation de la balise : $e');
    }
  }

  /// Traite une balise scannée
  Future<void> processScannedTag(int tagId, String token) async {
    try {
      _currentTag = await _tagsService.fetchTagById(tagId, token);
      notifyListeners();
    } catch (e) {
      print('Erreur lors de la récupération des détails de la balise : $e');
    }
  }
}
