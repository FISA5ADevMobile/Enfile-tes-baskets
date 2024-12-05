import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class TagsPage extends StatefulWidget {
  final String className;
  final int classId;
  final int courseId;

  TagsPage({
    required this.className,
    required this.classId,
    required this.courseId,
  });

  @override
  _TagsPageState createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  List<dynamic> tags = [];
  String filter = "Toutes";
  bool isCameraActive = false;

  @override
  void initState() {
    super.initState();
    fetchTags();
  }

  Future<void> resetTags() async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:8080/classes/${widget.courseId}/tags/reset'),
      headers: {'Content-Type': 'application/json; charset=utf-8'},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Tag successfully reinit')),
      );
      fetchTags();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error reinit tags')),
      );
    }
  }

  Future<void> fetchTags() async {
    try {
      // Fetch tags for the class
      final classTagsResponse = await http.get(
        Uri.parse('http://10.0.2.2:8080/tags/class/${widget.classId}'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      // Fetch tags for the course
      final courseTagsResponse = await http.get(
        Uri.parse('http://10.0.2.2:8080/tags/course/${widget.courseId}'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (classTagsResponse.statusCode == 200 &&
          courseTagsResponse.statusCode == 200) {
        final classTags = List<Map<String, dynamic>>.from(
            json.decode(classTagsResponse.body));
        final courseTags = List<Map<String, dynamic>>.from(
            json.decode(courseTagsResponse.body));

        // Merge tags and mark validated ones
        setState(() {
          tags = classTags.map((tag) {
            final isValidated =
                courseTags.any((courseTag) => courseTag['id'] == tag['id']);
            tag['validated'] = isValidated;
            return tag;
          }).toList();
        });
      } else {
        print(
            "Error fetching tags: ${classTagsResponse.statusCode}, ${courseTagsResponse.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  Future<void> fetchTagDetails(String tagId) async {
    try {
      final response = await http.get(
        Uri.parse('http://10.0.2.2:8080/tags/$tagId/description'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        final description =
            response.body; // Assuming the description is plain text
        showTagPopup(description, tagId);
      } else {
        showTagPopup("Tag not found or server error", null);
      }
    } catch (e) {
      showTagPopup("Connection error: $e", null);
    }
  }

  void showTagPopup(String message, String? tagId) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Tag Details'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Close'),
            ),
            if (tagId != null)
              ElevatedButton(
                onPressed: () {
                  validateTag(tagId);
                  Navigator.of(context).pop();
                },
                child: Text('Validate'),
              ),
          ],
        );
      },
    );
  }

  Future<void> validateTag(String tagId) async {
    try {
      final response = await http.post(
        Uri.parse(
            'http://10.0.2.2:8080/classes/${widget.classId}/courseId/${widget.classId}/tags/$tagId/validate?userId=1'),
        headers: {'Content-Type': 'application/json; charset=utf-8'},
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Tag successfully validated')),
        );
        fetchTags(); // Refresh the tags
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error validating tag')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Connection error: $e')),
      );
    }
  }

  void toggleCamera() {
    setState(() {
      isCameraActive = !isCameraActive;
    });
  }

  List<dynamic> filteredTags() {
    if (filter == "Validées") {
      return tags.where((tag) => tag['validated'] == true).toList();
    } else if (filter == "Non Validées") {
      return tags.where((tag) => tag['validated'] == false).toList();
    }
    return tags;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Parcours d’orientation',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: resetTags,
          ),
        ],
        backgroundColor: Color(0xFF0081A1),
      ),
      body: isCameraActive
          ? MobileScanner(
              onDetect: (barcode) {
                if (barcode.barcodes.isNotEmpty) {
                  final idTag = barcode.barcodes.first.rawValue;
                  if (idTag != null) {
                    fetchTagDetails(idTag);
                  }
                  toggleCamera();
                }
              },
            )
          : Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      _buildFilterButton("Toutes"),
                      _buildFilterButton("Validées"),
                      _buildFilterButton("Non Validées"),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: filteredTags().length,
                    itemBuilder: (context, index) {
                      final tag = filteredTags()[index];
                      return Card(
                        margin:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(16),
                                  color: tag['validated']
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12, vertical: 4),
                                child: Text(
                                  tag['validated'] ? 'Validée' : 'Non Validée',
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      tag['name'],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '15 Sept. 2024, 15:22', // Replace with actual timestamp if available
                                      style: TextStyle(
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: toggleCamera,
        backgroundColor: Color(0xFF0081A1),
        child: Icon(
          isCameraActive ? Icons.close : Icons.qr_code,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
          // Handle navigation between pages
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Communautés',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Parcours',
          ),
        ],
        selectedItemColor: Color(0xFF0081A1),
        unselectedItemColor: Colors.grey,
      ),
    );
  }

  Widget _buildFilterButton(String label) {
    return ElevatedButton(
      onPressed: () {
        setState(() {
          filter = label;
        });
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: filter == label ? Color(0xFF0081A1) : Colors.grey[300],
        foregroundColor: filter == label ? Colors.white : Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      child: Text(label),
    );
  }
}
