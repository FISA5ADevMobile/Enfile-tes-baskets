class Course {
  final String id;
  final String name;
  final String description;

  Course({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }
}
