import 'dart:typed_data';
import 'post.dart';

class Community {
  final int id;
  final String name;
  final String description;
  final DateTime? banDate;
  final bool isPublic;
  final int adminId;
  final List<int> moderatorIds;
  final List<Post> posts;
  final List<int> bannedUserIds;
  final String? categoryName;
  final Uint8List? image;
  final bool joined;

  Community({
    required this.id,
    required this.name,
    required this.description,
    this.banDate,
    required this.isPublic,
    required this.adminId,
    required this.moderatorIds,
    required this.posts,
    required this.bannedUserIds,
    this.categoryName,
    this.image,
    required this.joined,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      banDate:
          json['banDate'] != null ? DateTime.tryParse(json['banDate']) : null,
      isPublic: json['isPublic'] as bool,
      adminId: json['adminId'] as int,
      moderatorIds: (json['moderatorIds'] as List<dynamic>?)
              ?.map((id) => id as int)
              .toList() ??
          [], // Assurer une liste vide si `null`
      posts: (json['posts'] as List<dynamic>?)
              ?.map((post) => Post.fromJson(post as Map<String, dynamic>))
              .toList() ??
          [], // Assurer une liste vide si `null`
      bannedUserIds: (json['bannedUserIds'] as List<dynamic>?)
              ?.map((id) => id as int)
              .toList() ??
          [], // Assurer une liste vide si `null`
      categoryName:
          json['categoryName'] as String?, // Gérer `null` correctement
      image: json['image'] != null
          ? Uint8List.fromList(List<int>.from(json['image']))
          : null,
      joined: json['joined'] as bool? ?? false, // Assurer `false` si `null`
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
      'moderatorIds': moderatorIds,
      'posts': posts.map((post) => post.toJson()).toList(),
      'bannedUserIds': bannedUserIds,
      'categoryName': categoryName,
      'image': image?.toList(),
      'joined': joined,
    };
  }
}
