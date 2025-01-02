import 'package:flutter/material.dart';
import '../models/actuality.dart';

class ActualityDetailPage extends StatelessWidget {
  final Actuality actuality;

  const ActualityDetailPage({Key? key, required this.actuality}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: actuality.imageBytes.isNotEmpty
                    ? Image.memory(
                  actuality.imageBytes,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 200,
                  fit: BoxFit.cover,
                )
                    : const Icon(
                  Icons.image_not_supported,
                  size: 100,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              actuality.title,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              actuality.description,
              style: const TextStyle(fontSize: 16),
              textAlign: TextAlign.justify,
            ),
            if (actuality.isEvent)
              const SizedBox(height: 24),
            if (actuality.isEvent)
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    print("Bouton d'événement cliqué");
                  },
                  child: const Text("Participer à l'événement"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
