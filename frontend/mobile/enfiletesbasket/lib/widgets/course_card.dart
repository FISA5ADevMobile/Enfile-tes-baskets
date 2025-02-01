import 'package:enfiletesbasket/screens/tags_page.dart';
import 'package:enfiletesbasket/services/course_provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/course.dart';

class CourseCard extends StatelessWidget {
  final Course course;

  const CourseCard({required this.course, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: ListTile(
        title: Text(
          course.className,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(course.classDescription),
        trailing: const Icon(Icons.chevron_right),
        onTap: () => _navigateToTagsPage(context, course),
      ),
    );
  }

  /// Navigation vers la page des tags avec vérification de l'ID du cours
  Future<void> _navigateToTagsPage(BuildContext context, Course course) async {
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String token = authProvider.token ?? '';

    try {
      var courseId = course.id;

      if (courseId != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TagsPage(
              className: course.className,
              courseId: course.id,
              classId: course.classId,
            ),
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Failed to fetch course ID. Please try again.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }
}
