import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/services/course_provider.dart';
import 'package:enfiletesbasket/widgets/course_card.dart';

class ClassesPage extends StatelessWidget {
  const ClassesPage({Key? key}) : super(key: key);

  Future<void> _fetchCourses(BuildContext context) async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final String token = authProvider.token ?? '';

    await courseProvider.fetchMyClasses(token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<void>(
        future: _fetchCourses(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          return Consumer<CourseProvider>(
            builder: (context, courseProvider, child) {
              if (courseProvider.myCourses.isEmpty) {
                return const Center(child: Text('Pas de parcours trouvé.'));
              }

              return ListView.builder(
                itemCount: courseProvider.myCourses.length,
                itemBuilder: (context, index) {
                  final course = courseProvider.myCourses[index];
                  return CourseCard(course: course);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showJoinCourseDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showJoinCourseDialog(BuildContext context) {
    String classPassword = "";
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final courseProvider = Provider.of<CourseProvider>(context, listen: false);
    final String token = authProvider.token ?? '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Rejoindre un parcours'),
          content: TextField(
            onChanged: (value) => classPassword = value,
            obscureText: true,
            decoration: const InputDecoration(labelText: 'Mot de passe du parcours'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Annuler'),
            ),
            ElevatedButton(
              onPressed: () async {
                final responseMessage = await courseProvider.subscribeToCourseWithPassword(
                  classPassword,
                  token,
                );

                Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Inscription à un parcours'),
                    content: Text(responseMessage),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Rejoindre'),
            ),
          ],
        );
      },
    );
  }
}
