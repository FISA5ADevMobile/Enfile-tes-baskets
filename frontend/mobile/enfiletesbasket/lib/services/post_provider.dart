import 'package:flutter/material.dart';
import '../models/post.dart';
import '/services/post_service.dart';

class PostProvider extends ChangeNotifier {
  final PostService _postService = PostService();

  List<Post> _posts = [];
  Post? _selectedPost;
  bool _isLoading = false;

  List<Post> get posts => _posts;
  Post? get selectedPost => _selectedPost;
  bool get isLoading => _isLoading;

  Future<void> loadAllPosts() async {
    _isLoading = true;
    notifyListeners();

    try {
      _posts = await _postService.fetchAllPosts();
    } catch (e) {
      print('Error fetching posts: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> loadPostById(int id) async {
    _isLoading = true;
    notifyListeners();

    try {
      _selectedPost = await _postService.fetchPostById(id);
    } catch (e) {
      print('Error fetching post: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> createPost(Map<String, dynamic> postData) async {
    _isLoading = true;
    notifyListeners();

    try {
      // ✅ Remplace `null` par `""` pour `relatedPostId`
      postData['relatedPostId'] = postData['relatedPostId'] ?? "";

      final newPost = await _postService.createPost(postData);
      _posts.add(newPost);
    } catch (e) {
      print('Error creating post: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> likePost(int postId) async {
    try {
      final likedPost = await _postService.likePost(postId);
      final index = _posts.indexWhere((post) => post.id == likedPost.id);
      if (index != -1) {
        _posts[index] = likedPost;
      }
    } catch (e) {
      print('Error liking post: $e');
    } finally {
      notifyListeners();
    }
  }

  Future<void> updatePost(int postId, Map<String, dynamic> updatedData) async {
    try {
      final updatedPost = await _postService.updatePost(postId, updatedData);
      final index = _posts.indexWhere((post) => post.id == updatedPost.id);
      if (index != -1) {
        _posts[index] = updatedPost;
      }
    } catch (e) {
      print('Error updating post: $e');
    } finally {
      notifyListeners();
    }
  }
}
