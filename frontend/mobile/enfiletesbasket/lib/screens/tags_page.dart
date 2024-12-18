import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/tags_provider.dart';
import '../widgets/FilterButtons.dart';
import '../widgets/TagCard.dart';

class TagsPage extends StatelessWidget {
  final String className;
  final int classId;
  final int courseId;

  const TagsPage({
    required this.className,
    required this.classId,
    required this.courseId,
  });

  @override
  Widget build(BuildContext context) {
    final tagsProvider = Provider.of<TagsProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Parcours d’orientation'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () => tagsProvider.resetTags(courseId),
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: tagsProvider.fetchTags(classId, courseId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('An error occurred: ${snapshot.error}'),
            );
          }

          return Column(
            children: [
              // Utilisation directe du FilterButtons
              FilterButtons(),
              Expanded(
                child: Consumer<TagsProvider>(
                  builder: (context, provider, child) {
                    final tags = provider.filteredTags;

                    if (tags.isEmpty) {
                      return Center(child: Text('No tags found.'));
                    }

                    return ListView.builder(
                      itemCount: tags.length,
                      itemBuilder: (context, index) {
                        final tag = tags[index];
                        return TagCard(
                          tag: tag,
                          onValidate: (tagId) {
                            provider.validateTag(classId, courseId, tagId, 1);
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: tagsProvider.toggleCamera,
        child: Icon(tagsProvider.isCameraActive ? Icons.close : Icons.qr_code),
      ),
    );
  }
}
