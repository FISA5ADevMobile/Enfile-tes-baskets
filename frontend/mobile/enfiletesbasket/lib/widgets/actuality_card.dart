import 'dart:typed_data';
import 'package:flutter/material.dart';
import '../utils/text_utils.dart';

class ActualityCard extends StatelessWidget {
  final int id;
  final String title;
  final String description;
  final Uint8List imageBytes;
  final bool isEvent;
  final DateTime publicationDate;
  final VoidCallback onTap;

  const ActualityCard({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.imageBytes,
    required this.isEvent,
    required this.publicationDate,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String shortenedDescription = truncateText(description, 50);
    final String decodedTitle = title;
    final String formattedDate =
        "${publicationDate.day.toString().padLeft(2, '0')}/${publicationDate.month.toString().padLeft(2, '0')}/${publicationDate.year}";

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
              color:Color.fromRGBO(0, 0, 0, 0.1),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
              child: imageBytes.isNotEmpty
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
            ),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    decodedTitle,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
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

            const Spacer(),
            Padding(
              padding: const EdgeInsets.only(right: 16.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  "Publiée le $formattedDate",
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
