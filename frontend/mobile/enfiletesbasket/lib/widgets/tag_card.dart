import 'package:enfiletesbasket/screens/tag_details_page.dart';
import 'package:flutter/material.dart';
import '../models/tag.dart';

class TagCard extends StatelessWidget {
  final Tag tag;
  final int courseId;
  final bool onValidate;

  const TagCard({
    required this.tag,
    required this.courseId,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        title: Text(
          tag.name,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        trailing: Container(
          constraints: const BoxConstraints(
            minWidth: 100,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: tag.validated ? const Color(0xFFC8A14E) : Colors.grey[400],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            tag.validated ? 'Validée' : 'Non validée',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: tag.validated ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        onTap: () {
        },
      ),
    );
  }
}
