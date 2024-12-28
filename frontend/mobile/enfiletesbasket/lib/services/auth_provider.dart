import 'package:enfiletesbasket/model/user.dart';
import 'package:flutter/material.dart';
import 'auth_service.dart';
import 'user_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _authService = AuthService();
  final UserService _userService = UserService();

  String? _token;
  User? _currentUser;

  String? get token => _token;
  User? get currentUser => _currentUser;
  bool get isAuthenticated => _token != null;

  /// Enregistrer un nouvel utilisateur
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

  /// Connexion d'un utilisateur
  Future<void> login(String email, String password) async {
    try {
      final response = await _authService.login(email, password);
      _token = response['token'];
      await saveToken(_token!);
      await fetchCurrentUser(); // Récupérer les informations utilisateur après la connexion
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  /// Déconnexion d'un utilisateur
  Future<void> logout() async {
    _token = null;
    _currentUser = null;
    await removeToken();
    notifyListeners();
  }

  /// Charger le token depuis SharedPreferences
  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');
    if (_token != null) {
      await fetchCurrentUser(); // Charger les informations utilisateur si le token existe
    }
    notifyListeners();
  }

  /// Sauvegarder le token dans SharedPreferences
  Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('jwt_token', token);
  }

  /// Supprimer le token depuis SharedPreferences
  Future<void> removeToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('jwt_token');
  }

  Future<String> getToken() async {
    if(token == null) await loadToken();
    return _token!;
  }

  /// Récupérer les informations de l'utilisateur actuel
  Future<void> fetchCurrentUser() async {
    if (_token == null) {
      throw Exception("Token manquant. Impossible de récupérer les informations utilisateur.");
    }

    try {
      final user = await _userService.getMe(_token!);
      _currentUser = user;
      print("Utilisateur actuel : ${_currentUser?.pseudo}, ${_currentUser?.email}");
      notifyListeners();
    } catch (e) {
      print("Erreur lors de la récupération des informations utilisateur : $e");
      throw e;
    }
  }
}
