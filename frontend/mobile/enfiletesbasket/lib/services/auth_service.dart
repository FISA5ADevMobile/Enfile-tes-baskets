import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://10.0.2.2:8081/api/auth";

  /// Inscription d'un nouvel utilisateur
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

    if (response.statusCode == 200 || response.statusCode == 201) {
      // Traite la réponse comme texte brut si elle n'est pas JSON
      final responseBody = response.body;
      print("Succès : $responseBody"); // Debug : affiche la réponse brute ou le message
    } else if (response.statusCode == 500) {
      // Traite l'erreur 500 spécifique
      if (response.body.contains("Email already in use")) {
        throw Exception("L'adresse e-mail est déjà utilisée.");
      } else {
        throw Exception("Erreur serveur : ${response.body}");
      }
    } else {
      // Erreur générale - essaye de lire le message d'erreur comme JSON
      try {
        final error = jsonDecode(response.body);
        throw Exception("Erreur lors de l'inscription : ${error['message']}");
      } catch (_) {
        throw Exception("Erreur lors de l'inscription : ${response.body}");
      }
    }
  }

  /// Connexion d'un utilisateur
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email, "password": password}),
    );

    if (response.statusCode == 200) {
      // Retourne la réponse comme JSON
      return jsonDecode(response.body);
    } else {
      // Traite les erreurs
      try {
        final error = jsonDecode(response.body);
        throw Exception("Échec de la connexion : ${error['message']}");
      } catch (_) {
        throw Exception("Échec de la connexion : ${response.body}");
      }
    }
  }

  /// Réinitialisation du mot de passe
  Future<void> resetPassword(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/reset-password'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      // Traite la réponse comme texte brut si elle n'est pas JSON
      final responseBody = response.body;
      print("Succès : $responseBody"); // Debug : affiche la réponse brute ou le message
    } else if (response.statusCode == 500) {
      // Traite l'erreur 500 spécifique
      if (response.body.contains("User  not found")) {
        throw Exception("Utilisateur non trouvé. Vérifiez l'adresse e-mail.");
      } else {
        throw Exception("Erreur serveur : ${response.body}");
      }
    } else {
      // Erreur générale - essaye de lire le message d'erreur comme JSON
      try {
        final error = jsonDecode(response.body);
        throw Exception("Erreur lors de la réinitialisation : ${error['message']}");
      } catch (_) {
        throw Exception("Erreur lors de la réinitialisation : ${response.body}");
      }
    }
  }
}
