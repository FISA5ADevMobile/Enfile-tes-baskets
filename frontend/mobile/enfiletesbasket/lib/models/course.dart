class Course {
  final int id;
  final int userId;
  final DateTime beginDate;
  final DateTime endDate;
  final int classId;
  final String className;
  final String classDescription;

  Course({
    required this.id,
    required this.userId,
    required this.beginDate,
    required this.endDate,
    required this.classId,
    required this.className,
    required this.classDescription,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['id'] as int,
      userId: json['userId'] as int,
      beginDate: (json['beginDate'] != null && json['beginDate'].length >= 3)
          ? DateTime(json['beginDate'][0], json['beginDate'][1], json['beginDate'][2])
          : DateTime(2025, 1, 1), // Valeur par défaut
      endDate: (json['endDate'] != null && json['endDate'].length >= 3)
          ? DateTime(json['endDate'][0], json['endDate'][1], json['endDate'][2])
          : DateTime(2099, 12, 31), // Valeur par défaut
      classId: json['classId'] as int,
      className: json['className'] ?? 'Nom inconnu',
      classDescription: json['classDescription'] ?? 'Description non disponible',
    );
  }
}
