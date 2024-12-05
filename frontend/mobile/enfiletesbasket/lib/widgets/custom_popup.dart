import 'package:flutter/material.dart';

class CustomPopup extends StatelessWidget {
  final String title;
  final String description;
  final List<Widget> actions;

  const CustomPopup({
    Key? key,
    required this.title,
    required this.description,
    required this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8, // Largeur relative à l'écran
        constraints: const BoxConstraints(maxHeight: 400), // Limite la hauteur
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0081A1),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: actions.map((action) {
                return Flexible(child: action); // S'assure que chaque bouton s'adapte
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
