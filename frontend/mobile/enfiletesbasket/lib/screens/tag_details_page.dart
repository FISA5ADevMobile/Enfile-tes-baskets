import 'package:flutter/material.dart';
import '../model/tag.dart';

class TagDetailsPage extends StatelessWidget {
  final Tag tag;

  const TagDetailsPage({required this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(tag.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tag.description,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text('Coordinates: (${tag.xPos}, ${tag.yPos})'),
            SizedBox(height: 20),
            Text(
              tag.validated ? 'Status: Validée' : 'Status: Non Validée',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: tag.validated ? Colors.green : Colors.red,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
