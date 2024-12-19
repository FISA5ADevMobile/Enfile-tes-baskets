import 'package:flutter/material.dart';
import '../services/tags_service.dart';
import '../model/tag.dart';

class TagsProvider extends ChangeNotifier {
  final TagsService _tagsService = TagsService();

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

  /// Active ou désactive la caméra
  void toggleCamera() {
    print("Toggle camera: $_isCameraActive");
    _isCameraActive = !_isCameraActive;
    notifyListeners();
  }

  /// Récupère toutes les balises pour une classe et un cours
  Future<void> fetchTags(int classId, int courseId) async {
    try {
      final fetchedTags = await _tagsService.fetchTags(classId, courseId);
      _tags = fetchedTags;
      notifyListeners();
    } catch (e) {
      print('Error fetching tags: $e');
    }
  }

  /// Réinitialise l'état des balises pour un cours
  Future<void> resetTags(int courseId) async {
    try {
      await _tagsService.resetTags(courseId);
      for (var tag in _tags) {
        tag.validated = false; // Met toutes les balises à non validé
      }
      notifyListeners();
    } catch (e) {
      print('Error resetting tags: $e');
    }
  }

  /// Valide une balise spécifique
  Future<void> validateTag(int classId, int courseId, int tagId, int userId) async {
    try {
      await _tagsService.validateTag(classId, courseId, tagId, userId);
      final tag = _tags.firstWhere(
            (tag) => tag.id == tagId,
        orElse: () => Tag(
          id: -1,
          name: "Unknown Tag",
          description: "Tag not found",
          validated: false,
          xPos: 0.0,
          yPos: 0.0,
        ),
      );
      if (tag.id != -1) {
        tag.validated = true; // Met à jour localement
      }
      notifyListeners();
    } catch (e) {
      print('Error validating tag: $e');
    }
  }

  /// Récupère les détails d'une balise spécifique si elle n'est pas chargée
  Future<void> fetchTagDetails(String tagId) async {
    try {
      final tag = await _tagsService.fetchTagDetails(tagId);
      if (!_tags.any((existingTag) => existingTag.id == tag.id)) {
        _tags.add(tag); // Ajoute la balise si elle n'existe pas déjà
      }
      notifyListeners();
    } catch (e) {
      print('Error fetching tag details: $e');
    }
  }

  /// Traite une balise scannée
  Future<void> processScannedTag(String tagId, int classId, int courseId) async {
    try {
      // Vérifie si la balise existe déjà
      final tag = _tags.firstWhere(
            (tag) => tag.id.toString() == tagId,
        orElse: () => Tag(
          id: -1,
          name: "Unknown Tag",
          description: "Tag not found",
          validated: false,
          xPos: 0.0,
          yPos: 0.0,
        ),
      );
      if (tag.id != -1) {
        tag.validated = true; // Met à jour comme validée
      } else {
        // Si elle n'existe pas, récupère ses détails
        await fetchTagDetails(tagId);
      }
      notifyListeners();
    } catch (e) {
      print('Error processing scanned tag: $e');
    }
  }
}
