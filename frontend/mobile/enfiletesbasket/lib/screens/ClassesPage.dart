import 'package:enfiletesbasket/services/classes_provider.dart';
import 'package:enfiletesbasket/widgets/CourseCard.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class ClassesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final classesProvider = Provider.of<ClassesProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'My Classes',
          style: TextStyle(
            color: Color(0xFFC8A14E),
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Color(0xFF0081A1),
      ),
      body: FutureBuilder(
        future: classesProvider.fetchSubscribedClasses(1), // Exemple : ID utilisateur = 1
        builder: (context, snapshot) {
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
                    .joinClass(1, password);
              },
              child: Text('Join'),
            ),
          ],
        );
      },
    );
  }
}
