import 'dart:convert';
import 'package:enfiletesbasket/models/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class UserService {
  String get _base => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8081';
  String get baseUrl => '$_base/api/users';

  /// Récupère les informations de l'utilisateur actuel
  Future<User> getMe(String token) async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/me'),
        headers: {
          'Content-Type': 'application/json; charset=utf-8',
          'Authorization': 'Bearer $token', // Ajout du token JWT
        },
      );
      print(baseUrl);
      print("Token: $token");
      print("Login: ${response.body}");
      print("Status: ${response.statusCode}");
      if (response.statusCode == 200) {
        print("Response getMe: ${response.body}");
        final Map<String, dynamic> data = json.decode(response.body);
        return User.fromJson(data); // Conversion JSON en objet User
      } else if (response.statusCode == 401) {
        throw Exception("Unauthorized: Token invalide ou expiré");
      } else {
        throw Exception("Failed to load user information");
      }
    } catch (e) {
      print("Error in getMe: $e");
      throw Exception("Error fetching user information: $e");
    }
  }
}