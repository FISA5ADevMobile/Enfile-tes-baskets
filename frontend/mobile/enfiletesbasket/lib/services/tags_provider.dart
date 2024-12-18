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

  void updateFilter(String filter) {
    _filter = filter;
    notifyListeners();
  }

  void toggleCamera() {
    _isCameraActive = !_isCameraActive;
    notifyListeners();
  }

  Future<void> fetchTags(int classId, int courseId) async {
    final fetchedTags = await _tagsService.fetchTags(classId, courseId);
    _tags = fetchedTags;
    notifyListeners();
  }

  Future<void> resetTags(int courseId) async {
    await _tagsService.resetTags(courseId);
    notifyListeners();
  }

  Future<void> validateTag(int classId, int courseId, int tagId, int userId) async {
    await _tagsService.validateTag(classId, courseId, tagId, userId);
    notifyListeners();
  }
}
