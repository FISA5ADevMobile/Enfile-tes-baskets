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
      id: json['id'] is int
          ? json['id']
          : int.tryParse(json['id'].toString()) ?? 0,
      nbLike: json['nbLike'] is int
          ? json['nbLike']
          : int.tryParse(json['nbLike'].toString()),
      nbPost: json['nbPost'] is int
          ? json['nbPost']
          : int.tryParse(json['nbPost'].toString()),
      relatedPostId: json['relatedPostId'] is int
          ? json['relatedPostId']
          : int.tryParse(json['relatedPostId'].toString()),
      content: json['content'] as String,
      datePost:
          json['datePost'] != null ? DateTime.parse(json['datePost']) : null,
      imageUrl: json['imageUrl'] as String?,
      visible: json['visible'] as bool,
      banDate: json['banDate'] != null ? DateTime.parse(json['banDate']) : null,
      username: json['username'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'relatedPostId': relatedPostId?.toString(),
      'content': content,
      'datePost': datePost?.toIso8601String(),
      'imageUrl': imageUrl,
      'nbLike': nbLike,
      'nbPost': nbPost,
      'visible': visible,
      'banDate': banDate?.toIso8601String(),
      'username': username,
    };
  }
}
