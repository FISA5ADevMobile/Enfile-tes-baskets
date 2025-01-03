import 'dart:typed_data';
import 'dart:convert';
import '../utils/image_utils.dart';

class Actuality {
  final int id;
  final String title;
  final String description;
  final Uint8List imageBytes;
  final bool isEvent;
  final DateTime publicationDate;

  Actuality({
    required this.id,
    required this.title,
    required this.description,
    required this.imageBytes,
    required this.isEvent,
    required this.publicationDate,
  });

  factory Actuality.fromJson(Map<String, dynamic> json) {
    return Actuality(
      id: json['id'] ?? 0,
      title: json['title'] ?? 'Titre non disponible',
      description: json['description'] ?? 'Description non disponible',
      imageBytes: json['image'] != null && json['image']!.isNotEmpty
          ? decodeBase64Image(json['image'])
          : Uint8List(0),
      isEvent: json['event'] ?? false,
      publicationDate: json['publicationDate'] != null
          ? DateTime.parse(json['publicationDate'])
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'image': base64Encode(imageBytes),
      'isEvent': isEvent,
      'publicationDate': publicationDate.toIso8601String(),
    };
  }
}
