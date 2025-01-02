class Course {
  final int id; // Correction ici : int au lieu de String
  final String name;
  final String description;

  Course({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int, // Assurez-vous que c'est un int
      name: json['name'] ?? 'No Name', // Gère les valeurs nulles
      description: json['description'] ?? 'No Description', // Gère les valeurs nulles
    );
  }
}
