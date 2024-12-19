class Actuality {
  final String title;
  final String description;
  final List<int> imageBytes;
  final bool isEvent;

  Actuality({
    required this.title,
    required this.description,
    required this.imageBytes,
    required this.isEvent,
  });

  // Factory method pour convertir depuis le JSON
  factory Actuality.fromJson(Map<String, dynamic> json) {
    return Actuality(
      title: json['title'],
      description: json['description'],
      imageBytes: List<int>.from(json['image']),
      isEvent: json['isEvent'],
    );
  }

  // Méthode pour convertir l'objet en JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': imageBytes,
      'isEvent': isEvent,
    };
  }
}
