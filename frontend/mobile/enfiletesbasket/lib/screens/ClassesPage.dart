import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/classes_provider.dart';

class ClassesPage extends StatefulWidget {
  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  bool _isInitialized = false; // Ajoutez un flag pour gérer l'initialisation

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Exécuter fetchSubscribedClasses uniquement une fois
    if (!_isInitialized) {
      final classesProvider = Provider.of<ClassesProvider>(context, listen: false);
      Future.microtask(() => classesProvider.fetchSubscribedClasses(1));
      _isInitialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: Consumer<ClassesProvider>(
        builder: (context, classesProvider, child) {
          if (classesProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          if (classesProvider.subscribedClasses.isEmpty) {
            return Center(child: Text('No classes found'));
          }

          return ListView.builder(
            itemCount: classesProvider.subscribedClasses.length,
            itemBuilder: (context, index) {
              final classData = classesProvider.subscribedClasses[index];
              final className = classData['name'];
              final classId = classData['id'];

              return ListTile(
                title: Text(className),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  if (classId is int) {
                    print("Meriem $classId");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Class ID is not valid')),
                    );
                  }
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
            decoration: InputDecoration(
              labelText: 'Password',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _joinClass(context, password);
              },
              child: Text('Join'),
            ),
          ],
        );
      },
    );
  }

  void _joinClass(BuildContext context, String password) async {
    // Capturer le ScaffoldMessenger avant de commencer l'opération
    final scaffoldMessenger = ScaffoldMessenger.of(context);
    final classesProvider = Provider.of<ClassesProvider>(context, listen: false);

    try {
      final result = await classesProvider.joinClass(1, password);
      print("Result: $result");

      // Utiliser scaffoldMessenger pour afficher la SnackBar
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text(result)),
      );
    } catch (e) {
      print("Error: $e");

      // Afficher une erreur si nécessaire
      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    }
  }

}
