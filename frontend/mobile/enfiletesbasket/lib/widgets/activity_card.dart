import 'package:flutter/material.dart';

class ActivityCard extends StatelessWidget {
  final String title;
  final String description;
  final String image; // Chemin de l'image dans les assets
  final bool isEvent;

  const ActivityCard({
    Key? key,
    required this.title,
    required this.description,
    required this.image,
    required this.isEvent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 500, // Largeur fixe pour chaque élément
      margin: const EdgeInsets.symmetric(horizontal: 8.0), // Espacement
      child: Card(
        elevation: 4, // Ombre pour l'effet visuel
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 300,
                child: Image.asset(
                  image, // Chargement de l'image depuis les assets
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                description,
                maxLines: 3, // Limite à 3 lignes
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
