import 'dart:convert';
import 'dart:typed_data';
import 'package:enfiletesbasket/models/post.dart';

class Community {
  final int id;
  final String name;
  final String description;
  final DateTime? banDate;
  final bool isPublic;
  final int adminId;
  final List<int> userIds;
  final List<int> moderatorIds;
  final List<Post> posts;
  final List<int> bannedUserIds;
  final String categoryName;
  final Uint8List? image;

  Community({
    required this.id,
    required this.name,
    required this.description,
    this.banDate,
    required this.isPublic,
    required this.adminId,
    required this.userIds,
    required this.moderatorIds,
    required this.posts,
    required this.bannedUserIds,
    required this.categoryName,
    this.image,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      banDate: json['banDate'] != null ? DateTime.parse(json['banDate']) : null,
      isPublic: json['isPublic'] as bool,
      adminId: json['adminId'] as int,
      userIds:
          (json['userIds'] as List<dynamic>).map((id) => id as int).toList(),
      moderatorIds: (json['moderatorIds'] as List<dynamic>)
          .map((id) => id as int)
          .toList(),
      posts: (json['posts'] as List<dynamic>)
          .map((post) => Post.fromJson(post as Map<String, dynamic>))
          .toList(),
      bannedUserIds: (json['bannedUserIds'] as List<dynamic>)
          .map((id) => id as int)
          .toList(),
      categoryName: json['categoryName'] as String,
      image: json['image'] != null ? base64Decode(json['image']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'banDate': banDate?.toIso8601String(),
      'isPublic': isPublic,
      'adminId': adminId,
      'userIds': userIds,
      'moderatorIds': moderatorIds,
      'posts': posts.map((post) => post.toJson()).toList(),
      'bannedUserIds': bannedUserIds,
      'categoryName': categoryName,
      'image': image != null ? base64Encode(image!) : null,
    };
  }
}
