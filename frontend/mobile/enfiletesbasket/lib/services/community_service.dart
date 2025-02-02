import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/community.dart';

class CommunityService {
  String get _base => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8081';
  String get _baseUrl => '$_base/communities';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<Community>> fetchAllCommunities() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/all');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(responseBody);
      return data.map((json) => Community.fromJson(json)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Échec du chargement des communautés');
    }
  }

  Future<Community> joinCommunity(int communityId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/join/$communityId');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(communityId),
    );

    if (response.statusCode == 201) {
      final String responseBody = utf8.decode(response.bodyBytes);
      return Community.fromJson(json.decode(responseBody));
    } else if (response.statusCode == 400) {
      throw Exception('Requête incorrecte : ${response.body}');
    } else {
      throw Exception('Échec de la participation à la communauté : ${response.body}');
    }
  }

  Future<Community?> fetchCommunityById(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      return Community.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Échec du chargement de la communauté');
    }
  }

  Future<Community> createCommunity(Map<String, dynamic> communityData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse(_baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(communityData),
    );

    if (response.statusCode == 201) {
      final String responseBody = utf8.decode(response.bodyBytes);
      return Community.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Échec de la création de la communauté');
    }
  }

  Future<Community> updateCommunity(int id, Map<String, dynamic> updatedData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec de la mise à jour de la communauté');
    }
  }

  Future<void> deleteCommunity(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Échec de la suppression de la communauté');
    }
  }

  Future<Community> createPostInCommunity(int communityId, Map<String, dynamic> postData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/post/$communityId');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: json.encode(postData),
    );

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Requête incorrecte : ${response.body}');
    } else if (response.statusCode == 204) {
      throw Exception('Aucun contenu : ${response.body}');
    } else {
      throw Exception('Échec de la création du post dans la communauté : ${response.body}');
    }
  }
}
