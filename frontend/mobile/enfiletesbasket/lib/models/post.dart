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
      id: (json['id']) as int,
      nbLike: _parseInt(json['nbLike']),
      nbPost: _parseInt(json['nbPost']),
      relatedPostId: _parseInt(json['relatedPostId']),
      content: json['content']?.toString() ?? '',
      datePost: _parseDate(json['datePost']),
      imageUrl: json['imageUrl']?.toString(),
      visible: json['visible'] ?? false,
      banDate: _parseDate(json['banDate']),
      username: json['username']?.toString() ?? 'Unknown',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id.toString(),
      'relatedPostId': relatedPostId?.toString(),
      'content': content,
      'datePost': _formatDate(datePost),
      'imageUrl': imageUrl,
      'nbLike': nbLike,
      'nbPost': nbPost,
      'visible': visible,
      'banDate': _formatDate(banDate),
      'username': username,
    };
  }

  /// Fonction pour parser les entiers de façon sécurisée
  static int? _parseInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    return int.tryParse(value.toString());
  }

  /// Fonction pour parser les dates de façon sécurisée
  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    try {
      if (value is int) {
        return DateTime.fromMillisecondsSinceEpoch(value); // ✅ Gère les timestamps
      } else if (value is String) {
        return DateTime.parse(value); // ✅ Gère les formats ISO 8601
      }
    } catch (e) {
      print('Erreur de parsing de la date: $value');
    }
    return null;
  }

  /// Fonction pour formater la date en "DD/MM/AAAA"
  static String _formatDate(DateTime? date) {
    if (date == null) return "";
    return "${date.day.toString().padLeft(2, '0')}/"
        "${date.month.toString().padLeft(2, '0')}/"
        "${date.year}";
  }
}
