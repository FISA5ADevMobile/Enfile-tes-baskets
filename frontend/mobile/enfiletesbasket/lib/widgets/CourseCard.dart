import 'package:enfiletesbasket/model/Course.dart';
import 'package:enfiletesbasket/screens/tags_page.dart';
import 'package:enfiletesbasket/services/CourseProvider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        title: Text(course.name),
        subtitle: Text(course.description),
        trailing: Icon(Icons.chevron_right),
        onTap: () => _navigateToTagsPage(context, course),
      ),
    );
  }

  Future<void> _navigateToTagsPage(BuildContext context, Course course) async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);

    final courseId = await courseProvider.fetchCourseId(1, int.parse(course.id)); // Exemple : ID utilisateur = 1

    if (courseId != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TagsPage(
            className: course.name,
            classId: int.parse(course.id),
            courseId: courseId,
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to fetch courseId')),
      );
    }
  }
}