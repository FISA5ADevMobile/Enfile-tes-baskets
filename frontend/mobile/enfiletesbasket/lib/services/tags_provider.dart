import 'package:flutter/material.dart';
import '../services/tags_service.dart';

class TagsProvider extends ChangeNotifier {
  final TagsService _tagsService = TagsService();

  List<Map<String, dynamic>> _tags = [];
  bool _isLoading = false;

  List<Map<String, dynamic>> get tags => _tags;
  bool get isLoading => _isLoading;

  Future<void> fetchTags(int classId, int courseId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final classTags = await _tagsService.fetchClassTags(classId);
      final courseTags = await _tagsService.fetchCourseTags(courseId);

      // Combine tags and mark validated ones
      _tags = classTags.map((tag) {
        tag['validated'] = courseTags.any((courseTag) => courseTag['id'] == tag['id']);
        return tag;
      }).toList();
    } catch (e) {
      print('Error fetching tags: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> resetTags(int courseId) async {
    try {
      await _tagsService.resetTags(courseId);
      notifyListeners();
    } catch (e) {
      print('Error resetting tags: $e');
    }
  }

  Future<void> validateTag(int classId, int courseId, String tagId, int userId) async {
    try {
      await _tagsService.validateTag(classId, courseId, tagId, userId);
      notifyListeners();
    } catch (e) {
      print('Error validating tag: $e');
    }
  }
}
