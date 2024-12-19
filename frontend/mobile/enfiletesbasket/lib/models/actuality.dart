import 'dart:typed_data';
import 'dart:convert';
import '../utils/image_utils.dart';

class Actuality {
  final String title;
  final String description;
  final Uint8List imageBytes;
  final bool isEvent;

  Actuality({
    required this.title,
    required this.description,
    required this.imageBytes,
    required this.isEvent,
  });

  factory Actuality.fromJson(Map<String, dynamic> json) {
    return Actuality(
      title: json['title'] ?? 'Titre non disponible',
      description: json['description'] ?? 'Description non disponible',
      imageBytes: json['image'] != null && json['image']!.isNotEmpty
          ? decodeBase64Image(json['image'])
          : Uint8List(0), // Image vide si non fournie
      isEvent: json['event'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'image': base64Encode(imageBytes),
      'isEvent': isEvent,
    };
  }
}
