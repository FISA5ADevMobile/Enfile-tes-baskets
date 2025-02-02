import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';

class PostService {
  String get _base => dotenv.env['API_BASE_URL'] ?? 'http://10.0.2.2:8081';
  String get _baseUrl => '$_base/api/post';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<Post>> fetchAllPosts() async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/all');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json, charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      final List<dynamic> data = json.decode(responseBody);
      return data.map((json) => Post.fromJson(json)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Échec du chargement des posts');
    }
  }

  Future<Post?> fetchPostById(int id) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/$id');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json, charset=UTF-8',
      },
    );

    if (response.statusCode == 200) {
      final String responseBody = utf8.decode(response.bodyBytes);
      return Post.fromJson(json.decode(responseBody));
    } else {
      throw Exception('Échec du chargement du post');
    }
  }

  Future<Post> createPost(Map<String, dynamic> postData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    // ✅ Toujours envoyer "" pour `relatedPostId` si vide
    final requestData = {
      'description': postData['description'],
      'image': postData['image'],
      'visible': postData['visible'],
      'relatedPostId': postData['relatedPostId'] ?? "",
    };

    final url = Uri.parse(_baseUrl);
    final response = await http.post(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(requestData),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec de la création du post');
    }
  }

  Future<Post> likePost(int postId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/like/$postId');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec du like sur le post');
    }
  }

  Future<Post> updatePost(int postId, Map<String, dynamic> updatedData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('Aucun jeton trouvé. L\'utilisateur n\'est peut-être pas authentifié.');
    }

    final url = Uri.parse('$_baseUrl/$postId');
    final response = await http.put(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(updatedData),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Échec de la mise à jour du post');
    }
  }
}
