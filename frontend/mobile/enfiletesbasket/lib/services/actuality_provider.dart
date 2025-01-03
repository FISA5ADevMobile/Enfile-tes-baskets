import 'package:flutter/material.dart';
import '../models/actuality.dart';
import 'actuality_service.dart';

class ActualityProvider extends ChangeNotifier {
  final ActualityService _actualityService = ActualityService();
  List<Actuality> _actualities = [];
  Actuality? _selectedActuality;
  bool _isLoading = false;
  bool _isSubscribed = false;
  List<Actuality> get actualities => _actualities;
  Actuality? get selectedActuality => _selectedActuality;
  bool get isLoading => _isLoading;
  bool get isSubscribed => _isSubscribed;

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

  Future<void> loadActualityById(int id) async {
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

  Future<void> checkIfSubscribed(int actualityId) async {
    _isLoading = true;
    notifyListeners();

    try {
      _isSubscribed = await _actualityService.checkIfSubscribed(actualityId);
    } catch (e) {
      print('Error checking subscription status: $e');
      _isSubscribed = false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> subscribeToEvent(int actualityId) async {
    _isLoading = true;
    notifyListeners();

    try {
      await _actualityService.subscribeToEvent(actualityId);
      _isSubscribed = true;
      print('Successfully subscribed to the event.');
    } catch (e) {
      print('Error subscribing to event: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

}
