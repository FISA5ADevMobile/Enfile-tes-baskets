import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/post.dart';

class PostService {
  static const String _baseUrl = 'http://10.0.2.2:8081/api/post';

  Future<String?> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('jwt_token');
  }

  Future<List<Post>> fetchAllPosts() async {
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
      return data.map((json) => Post.fromJson(json)).toList();
    } else if (response.statusCode == 204) {
      return [];
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<Post?> fetchPostById(int id) async {
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
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load post');
    }
  }

  Future<Post> createPost(Map<String, dynamic> postData) async {
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
      body: json.encode(postData),
    );

    if (response.statusCode == 200) {
      return Post.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<Post> likePost(int postId) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
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
      throw Exception('Failed to like post');
    }
  }

  Future<Post> updatePost(int postId, Map<String, dynamic> updatedData) async {
    final token = await _getToken();
    if (token == null) {
      throw Exception('No token found. User might not be authenticated.');
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
      throw Exception('Failed to update post');
    }
  }
}
