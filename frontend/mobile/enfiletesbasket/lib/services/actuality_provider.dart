import 'package:flutter/material.dart';
import '../models/actuality.dart';
import 'activity_service.dart';

class ActualityProvider extends ChangeNotifier {
  final ActualityService _actualityService = ActualityService();
  List<Actuality> _actualities = [];
  Actuality? _selectedActuality;
  bool _isLoading = false;

  List<Actuality> get actualities => _actualities;
  Actuality? get selectedActuality => _selectedActuality;
  bool get isLoading => _isLoading;

  Future<void> loadActualities() async {
    _isLoading = true;
    notifyListeners();

    try {
      _actualities = await _actualityService.fetchAllActualities();
    } catch (e) {
      print('Error loading actualities: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<Actuality?> loadActualityById(int id) async {
    try {
      return await _actualityService.fetchActualityById(id);
    } catch (e) {
      print('Error loading actuality by id: $e');
      return null;
    }
  }

}

