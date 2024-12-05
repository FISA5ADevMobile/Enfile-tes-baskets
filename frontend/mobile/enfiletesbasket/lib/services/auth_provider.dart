import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  String? _token;

  String? get token => _token;
  bool get isAuthenticated => _token != null;

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    try {
      await _authService.register(username: username, email: email, password: password);
    } catch (e) {
      throw e;
    }
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await _authService.login(email, password);
      _token = response['token'];
      await saveToken(_token!);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> logout() async {
    _token = null;
    await removeToken();
    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    notifyListeners();
  }

  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }
}
