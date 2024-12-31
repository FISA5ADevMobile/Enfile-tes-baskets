import 'package:flutter/material.dart';
import '../models/actuality.dart';
import '../services/actuality_service.dart';

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

  Future<void> loadActualityById(String id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedActuality = await _actualityService.fetchActualityById(id);
    } catch (e) {
      print('Error loading actuality by id: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}

