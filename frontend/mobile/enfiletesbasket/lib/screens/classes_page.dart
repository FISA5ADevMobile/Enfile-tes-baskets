import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/services/classes_provider.dart';
import 'package:enfiletesbasket/widgets/course_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClassesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classesProvider = Provider.of<ClassesProvider>(context, listen: false);
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      body: FutureBuilder(
        future: () async {
          final String token = authProvider.token ?? '';
          return await classesProvider.fetchSubscribedClasses(authProvider.currentUser!.id, token);
        }(),        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          return Consumer<ClassesProvider>(
            builder: (context, provider, child) {
              if (provider.subscribedClasses.isEmpty) {
                return Center(child: Text('No classes found'));
              }

              return ListView.builder(
                itemCount: provider.subscribedClasses.length,
                itemBuilder: (context, index) {
                  final course = provider.subscribedClasses[index];
                  return CourseCard(course: course);
                },
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showJoinClassDialog(context),
        child: Icon(Icons.add),
      ),
    );
  }

  void _showJoinClassDialog(BuildContext context) {
    String password = "";
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final String token = authProvider.token ?? '';
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Join a Class'),
          content: TextField(
            onChanged: (value) => password = value,
            obscureText: true,
            decoration: InputDecoration(labelText: 'Password'),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                Provider.of<ClassesProvider>(context, listen: false)
                    .joinClass(authProvider.currentUser!.id, password, token);
              },
              child: Text('Join'),
            ),
          ],
        );
      },
    );
  }
}
