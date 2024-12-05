import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'tagsPage.dart';

class ClassesPage extends StatefulWidget {
  @override
  _ClassesPageState createState() => _ClassesPageState();
}

class _ClassesPageState extends State<ClassesPage> {
  List<Map<String, dynamic>> subscribedClasses =
      []; // List of subscribed classes
  String password = ""; // Password for joining a class

  @override
  void initState() {
    super.initState();
    fetchSubscribedClasses();
  }

  /// Fetch classes subscribed by the user
  Future<void> fetchSubscribedClasses() async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/classes/subscribed/1'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        setState(() {
          subscribedClasses = List<Map<String, dynamic>>.from(
            json.decode(response.body).map((classData) {
              classData['id'] = int.tryParse(classData['id'].toString()) ??
                  classData['id']; // Ensure id is an int
              return classData;
            }),
          );
        });
      } else {
        print("Error fetching classes: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  /// Join a class with the provided password
  Future<void> joinClass() async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:8080/classes/join/1?password=$password'), // Append password as query parameter
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Class joined successfully!')),
        );
        fetchSubscribedClasses(); // Refresh the class list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error joining the class')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error: $e')),
      );
    }
  }

  Future<void> navigateToTagsPage(String className, int classId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/courses/user/1?classId=$classId'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        // Directly parse the response body as an integer
        final courseId = int.tryParse(response.body.toString());

        if (courseId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TagsPage(
                className: className,
                classId: classId,
                courseId: courseId,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Invalid courseId received from server')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text('Error fetching courseId: ${response.statusCode}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error: $e')),
      );
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
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: subscribedClasses.length,
              itemBuilder: (context, index) {
                final classData = subscribedClasses[index];
                final className = classData['name'];
                final classId = classData['id'];

                return ListTile(
                  title: Text(className),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    if (classId is int) {
                      print("Meriem $classId");
                      navigateToTagsPage(className, classId);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Class ID is not valid')),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Display a dialog to enter the password
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
                      joinClass();
                    },
                    child: Text('Join'),
                  ),
                ],
              );
            },
          );
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
