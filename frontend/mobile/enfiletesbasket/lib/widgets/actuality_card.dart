import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../utils/text_utils.dart';

class ActualityCard extends StatelessWidget {
  final String title;
  final String description;
  final Uint8List imageBytes;
  final bool isEvent;

  const ActualityCard({
    Key? key,
    required this.title,
    required this.description,
    required this.imageBytes,
    required this.isEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String shortenedDescription = truncateText(decodeText(description), 50); // Décodage
    final String decodedTitle = decodeText(title);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            imageBytes.isNotEmpty
                ? Image.memory(
              imageBytes,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            )
                : Container(
              color: Colors.grey[200],
              height: 200,
              width: double.infinity,
              child: const Icon(
                Icons.image_not_supported,
                color: Colors.grey,
                size: 50,
              ),
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    decodedTitle, // Utilisation du titre décodé
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    shortenedDescription, // Utilisation de la description décodée
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
