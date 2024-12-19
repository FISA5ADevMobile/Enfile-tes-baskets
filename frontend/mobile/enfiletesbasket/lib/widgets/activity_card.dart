import 'dart:typed_data'; // Assurez-vous d'utiliser celui-ci
import 'package:flutter/material.dart';
import '../models/activity.dart';


class ActivityCard extends StatelessWidget {
  final Activity activity;

  const ActivityCard({Key? key, required this.activity}) : super(key: key);

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
                child: activity.imageBytes.isNotEmpty
                    ? Image.memory(
                  Uint8List.fromList(activity.imageBytes),
                  fit: BoxFit.cover,
                )
                    : const Icon(Icons.image_not_supported), // Icône par défaut si l'image est absente
              ),
              const SizedBox(height: 16),
              Text(
                activity.title,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 4),
              Text(
                activity.description,
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
