import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../services/tags_provider.dart';

class TagsPage extends StatelessWidget {
  final String className;
  final int classId;
  final int courseId;

  const TagsPage({
    required this.className,
    required this.classId,
    required this.courseId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final tagsProvider = Provider.of<TagsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tags for $className'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => tagsProvider.resetTags(courseId),
          ),
        ],
      ),
      body: tagsProvider.isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: tagsProvider.tags.length,
        itemBuilder: (context, index) {
          final tag = tagsProvider.tags[index];
          return ListTile(
            title: Text(tag['name']),
            trailing: Text(
              tag['validated'] ? 'Validated' : 'Not Validated',
              style: TextStyle(
                color: tag['validated'] ? Colors.green : Colors.red,
              ),
            ),
            onTap: () {
              // Show tag details or validate
            },
          );
        },
      ),
    );
  }
}
