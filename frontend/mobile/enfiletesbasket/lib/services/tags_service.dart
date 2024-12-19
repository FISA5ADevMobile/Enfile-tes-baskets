import '../model/tag.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class TagsService {

  final String baseUrl = "http://10.0.2.2:8081";

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

  Future<List<Tag>> fetchClassTags(int classId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/tags/class/$classId'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    print("ResponseTags: ${response.body}");

    if (response.statusCode == 200) {
      // Décoder la réponse JSON
      final List<dynamic> jsonData = json.decode(response.body);

      // Mapper chaque élément JSON sur un objet `Tag`
      return jsonData.map((tagJson) => Tag.fromJson(tagJson)).toList();
    } else {
      throw Exception('Failed to fetch class tags');
    }
  }

  /// Réinitialise toutes les balises à non validées
  Future<void> resetTags(int courseId) async {
    for (var tag in _mockTags) {
      tag.validated = false;
    }
  }

  /// Valide une balise spécifique
  Future<void> validateTag(int classId, int courseId, int tagId, int userId) async {
    final tag = _mockTags.firstWhere((tag) => tag.id == tagId, orElse: () => throw Exception('Tag not found'));
    tag.validated = true;
  }

  /// Récupère les détails d'une balise spécifique
  Future<Tag> fetchTagDetails(String tagId) async {
    // Simuler un délai pour imiter un appel réseau
    await Future.delayed(Duration(seconds: 1));
    return _mockTags.firstWhere((tag) => tag.id.toString() == tagId, orElse: () => throw Exception('Tag not found'));
  }
}
