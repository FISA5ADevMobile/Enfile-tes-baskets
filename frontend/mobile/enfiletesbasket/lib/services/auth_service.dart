import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://10.0.2.2:8081/api/auth";

  Future<void> register({
    required String username,
    required String email,
    required String password,
  }) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "username": username,
        "email": email,
        "name": null, // Nom par défaut à null
        "firstName": null, // Prénom par défaut à null
        "password": password,
      }),
    );

    if (response.statusCode != 201) {
      try {
        final error = jsonDecode(response.body);
        throw Exception("Erreur lors de l'inscription : ${error['message']}");
      } catch (_) {
        throw Exception("Erreur lors de l'inscription : ${response.body}");
      }
    }
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Échec de la connexion : ${jsonDecode(response.body)['message']}");
    }
  }

  // Nouvelle méthode pour réinitialiser le mot de passe
  Future<void> resetPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode != 200) {
      try {
        final error = jsonDecode(response.body);
        throw Exception("Erreur lors de la réinitialisation : ${error['message']}");
      } catch (_) {
        throw Exception("Erreur lors de la réinitialisation : ${response.body}");
      }
    }
  }
}
