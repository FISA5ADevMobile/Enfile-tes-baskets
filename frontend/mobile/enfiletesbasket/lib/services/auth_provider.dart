import 'package:enfiletesbasket/models/user.dart';
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

  Future<void> login(String email, String password, bool rememberMe) async {
    try {
      final response = await _authService.login(email, password);
      _token = response['token'];
      await saveToken(_token!);

      if (rememberMe) {
        await saveRememberMe(true);
      } else {
        await saveRememberMe(false);
      }

      await fetchCurrentUser();
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> saveRememberMe(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('remember_me', value);
  }

  Future<bool> loadRememberMe() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('remember_me') ?? false;
  }


  Future<void> autoLogin() async {
    final rememberMe = await loadRememberMe();
    if (rememberMe) {
      await loadToken();
      if (_token == null) {
        print("Aucun token valide trouvé. Redirection vers l'écran de connexion.");
      }
    } else {
      print("Connexion automatique désactivée par l'utilisateur.");
    }
  }

  Future<void> logout() async {
    if (_token != null) {
      try {
        await _authService.logout(_token!);
      } catch (e) {
        print("Erreur lors de la déconnexion API : $e");
      }
    }
    _token = null;
    _currentUser = null;
    await removeToken();
    await saveRememberMe(false);
    notifyListeners();
  }

  Future<void> loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('jwt_token');

    if (_token != null) {
      try {
        await fetchCurrentUser();
      } catch (e) {
        await logout();
      }
    }

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

  Future<String> getToken() async {
    if(token == null) await loadToken();
    return _token!;
  }

  Future<void> fetchCurrentUser() async {
    if (_token == null) {
      throw Exception("Token manquant. Impossible de récupérer les informations utilisateur.");
    }

    try {
      final user = await _userService.getMe(_token!);
      _currentUser = user;
      notifyListeners();
    } catch (e) {
      throw Exception("Token invalide ou expiré.");
    }
  }

}
