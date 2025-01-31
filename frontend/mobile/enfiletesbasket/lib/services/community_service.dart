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
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/all');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Community.fromJson(json)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to load communities');
    }
  }

  Future<Community> joinCommunity(int communityId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/join/$communityId');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(communityId),
    );

    if (response.statusCode == 201) {
      return Community.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Bad Request: ${response.body}');
    } else {
      throw Exception('Failed to join community: ${response.body}');
    }
  }

  Future<Community?> fetchCommunityById(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load community');
    }
  }

  Future<Community> createCommunity(Map<String, dynamic> communityData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse(_baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(communityData),
    );

    if (response.statusCode == 201) {
      return Community.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create community');
    }
  }

  Future<Community> updateCommunity(
      int id, Map<String, dynamic> updatedData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to update community');
    }
  }

  Future<void> deleteCommunity(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.delete(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete community');
    }
  }

  Future<Community> createPostInCommunity(
      int communityId, Map<String, dynamic> postData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
    }

    final url = Uri.parse('$_baseUrl/post/$communityId');
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(postData),
    );

    if (response.statusCode == 200) {
      return Community.fromJson(json.decode(response.body));
    } else if (response.statusCode == 400) {
      throw Exception('Bad Request: ${response.body}');
    } else if (response.statusCode == 204) {
      throw Exception('No Content: ${response.body}');
    } else {
      throw Exception('Failed to create post in community: ${response.body}');
    }
  }
}
