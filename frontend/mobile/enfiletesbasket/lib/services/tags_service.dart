import '../model/tag.dart';

class TagsService {
  // Liste statique pour simuler les données
  final List<Tag> _mockTags = [
    Tag(
      id: 1,
      name: "Balise 1",
      description: "Emplacement initial de l’activité d’orientation",
      xPos: 0.0,
      yPos: 0.0,
      validated: false,
    ),
    Tag(
      id: 2,
      name: "Balise 2",
      description: "Premier point de contrôle du parcours",
      xPos: 10.5,
      yPos: 5.2,
      validated: false,
    ),
    Tag(
      id: 3,
      name: "Balise 3",
      description: "Emplacement final de l’activité",
      xPos: 25.3,
      yPos: 18.7,
      validated: true,
    ),
  ];

  // Simule l'appel API pour récupérer les tags
  Future<List<Tag>> fetchTags(int classId, int courseId) async {
    // Simuler un délai pour imiter un appel réseau
    await Future.delayed(Duration(seconds: 1));
    return _mockTags;
  }

  // Simule la réinitialisation des tags
  Future<void> resetTags(int courseId) async {
    for (var tag in _mockTags) {
      tag.validated = false;
    }
  }

  // Simule la validation d'un tag
  Future<void> validateTag(int classId, int courseId, int tagId, int userId) async {
    final tag = _mockTags.firstWhere((tag) => tag.id == tagId);
    tag.validated = true;
  }
}
