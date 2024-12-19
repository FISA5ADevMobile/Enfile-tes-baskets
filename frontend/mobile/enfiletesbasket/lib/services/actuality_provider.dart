import 'package:flutter/material.dart';
import '../models/actuality.dart';
import '../services/actuality_service.dart';

class ActualityProvider extends ChangeNotifier {
  final ActualityService _actualityService = ActualityService();
  List<Actuality> _actualities = [];
  bool _isLoading = false;

  List<Actuality> get actualities => _actualities;
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
}
