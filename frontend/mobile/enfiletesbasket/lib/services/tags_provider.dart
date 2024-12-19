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
    _isCameraActive = !_isCameraActive;
    notifyListeners();
  }

  /// Récupère toutes les balises pour une classe et un cours
  Future<void> fetchTags(int classId, int courseId) async {
    try {
      _tags = await _tagsService.fetchClassTags(classId);
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
          id: tagId,
          name: "Unknown Tag",
          description: "Tag not found",
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
      print('Error validating tag: $e');
    }
  }

  /// Traite une balise scannée
  Future<void> processScannedTag(String tagId, int classId, int courseId) async {
    try {
      final parsedTagId = int.tryParse(tagId);
      if (parsedTagId == null) {
        print('Invalid tag ID: $tagId');
        return;
      }
      final tag = _tags.firstWhere(
            (tag) => tag.id == parsedTagId,
        orElse: () => Tag(
          id: parsedTagId,
          name: "Unknown Tag",
          description: "Tag not found",
          validated: false,
          xPos: 0.0,
          yPos: 0.0,
        ),
      );
      if (tag.id != -1) {
        tag.validated = true; // Met à jour comme validée
        notifyListeners();
      }
    } catch (e) {
      print('Error processing scanned tag: $e');
    }
  }
}
