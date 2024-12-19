import 'package:flutter/material.dart';
import '../utils/text_utils.dart';

class ActualityCard extends StatelessWidget {
  final String title;
  final String description;
  final String image; // Chemin de l'image dans les assets
  final bool isEvent;

  const ActualityCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.isEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String shortenedDescription = truncateText(description, 50);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.0), // Bordures arrondies
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1), // Ombre légère
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        color: Colors.white, // Couleur de fond blanche
      ),
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12.0), // Applique l'arrondi à l'image et au contenu
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              image,
              fit: BoxFit.cover,
              width: double.infinity, // Prend toute la largeur disponible
              height: 200,
            ),
            const SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    shortenedDescription,
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
