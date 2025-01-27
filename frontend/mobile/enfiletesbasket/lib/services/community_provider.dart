import 'package:flutter/material.dart';
import '../models/community.dart';
import '../services/community_service.dart';

class CommunityProvider extends ChangeNotifier {
  final CommunityService _communityService = CommunityService();

  List<Community> _communities = [];
  Community? _selectedCommunity;
  bool _isLoading = false;

  List<Community> get communities => _communities;
  Community? get selectedCommunity => _selectedCommunity;
  bool get isLoading => _isLoading;

  Future<void> loadAllCommunities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _communities = await _communityService.fetchAllCommunities();
    } catch (e) {
      print('Error fetching communities: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadCommunityById(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedCommunity = await _communityService.fetchCommunityById(id);
    } catch (e) {
      print('Error fetching community: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createCommunity(Map<String, dynamic> communityData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final newCommunity =
          await _communityService.createCommunity(communityData);
      _communities.add(newCommunity);
    } catch (e) {
      print('Error creating community: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> joinCommunity(int communityId) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedCommunity =
          await _communityService.joinCommunity(communityId);
      final index =
          _communities.indexWhere((community) => community.id == communityId);
      if (index != -1) {
        _communities[index] =
            updatedCommunity; // Mettre à jour la communauté dans la liste
      }
    } catch (e) {
      print('Error joining community: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateCommunity(int id, Map<String, dynamic> updatedData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedCommunity =
          await _communityService.updateCommunity(id, updatedData);
      final index = _communities.indexWhere((community) => community.id == id);
      if (index != -1) {
        _communities[index] = updatedCommunity;
      }
    } catch (e) {
      print('Error updating community: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> deleteCommunity(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _communityService.deleteCommunity(id);
      _communities.removeWhere((community) => community.id == id);
    } catch (e) {
      print('Error deleting community: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPostInCommunity(
      int communityId, Map<String, dynamic> postData) async {
    _isLoading = true;
    notifyListeners();

    try {
      final updatedCommunity =
          await _communityService.createPostInCommunity(communityId, postData);
      final index =
          _communities.indexWhere((community) => community.id == communityId);
      if (index != -1) {
        _communities[index] = updatedCommunity; // Mise à jour locale
      }
    } catch (e) {
      print('Error creating post in community: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void selectCommunity(int index) {
    if (index >= 0 && index < _communities.length) {
      _selectedCommunity = _communities[index];
      notifyListeners();
    }
  }
}
