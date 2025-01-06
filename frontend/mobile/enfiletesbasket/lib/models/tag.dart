class Tag {
  final int id;
  final String name;
  final String description;
  final double xPos;
  final double yPos;
  bool validated;

  Tag({
    required this.id,
    required this.name,
    required this.description,
    required this.xPos,
    required this.yPos,
    this.validated = false,
  });

  factory Tag.fromJson(Map<String, dynamic> json) {
    return Tag(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      xPos: (json['xpos'] ?? 0).toDouble(),
      yPos: (json['ypos'] ?? 0).toDouble(),
      validated: json['validated'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'xPos': xPos,
      'yPos': yPos,
      'validated': validated,
    };
  }
}
