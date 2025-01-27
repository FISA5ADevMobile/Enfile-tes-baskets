import 'dart:convert';

class Post {
  final int id;
  final String content;
  final DateTime? datePost;
  final String? imageUrl;
  final int? nbLike;
  final int? nbPost;
  final bool visible;
  final DateTime? banDate;
  final String username;
  final int? relatedPostId;

  Post({
    required this.id,
    required this.content,
    this.datePost,
    this.imageUrl,
    this.nbLike,
    this.nbPost,
    required this.visible,
    this.banDate,
    required this.username,
    this.relatedPostId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'] as int,
      content: json['content'] as String,
      datePost:
          json['datePost'] != null ? DateTime.parse(json['datePost']) : null,
      imageUrl: json['imageUrl'] as String?,
      nbLike: json['nbLike'] as int?,
      nbPost: json['nbPost'] as int?,
      visible: json['visible'] as bool,
      banDate: json['banDate'] != null ? DateTime.parse(json['banDate']) : null,
      username: json['username'] as String,
      relatedPostId: json['relatedPostId'] as int?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'content': content,
      'datePost': datePost?.toIso8601String(),
      'imageUrl': imageUrl,
      'nbLike': nbLike,
      'nbPost': nbPost,
      'visible': visible,
      'banDate': banDate?.toIso8601String(),
      'username': username,
      'relatedPostId': relatedPostId,
    };
  }
}
