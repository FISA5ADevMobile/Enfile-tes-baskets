import 'package:enfiletesbasket/screens/TagDetailsPage.dart';
import 'package:flutter/material.dart';
import '../model/tag.dart';

class TagCard extends StatelessWidget {
  final Tag tag;
  final Function(int tagId) onValidate;

  const TagCard({
    required this.tag,
    required this.onValidate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        title: Text(tag.name),
        subtitle: Text(tag.description),
        trailing: ElevatedButton(
          onPressed: () => onValidate(tag.id),
          child: Text(tag.validated ? 'Validé' : 'Valider'),
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TagDetailsPage(tag: tag),
            ),
          );
        },
      ),
    );
  }
}
