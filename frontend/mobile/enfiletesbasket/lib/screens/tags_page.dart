import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import '../services/auth_provider.dart';
import '../services/tags_provider.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/tag_card.dart';

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
    final authProvider = Provider.of<AuthProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Parcours d’orientation'),
        actions: [
          Consumer<TagsProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: Icon(Icons.refresh),
                onPressed: () {
                  provider.resetTags(courseId);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Tags reset successfully')),
                  );
                },
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future:() async {
        final String token = authProvider.token ?? '';
        return tagsProvider.fetchTags(classId, courseId, token);
      }(),

        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('An error occurred: ${snapshot.error}'));
          }

          return Consumer<TagsProvider>(
            builder: (context, provider, child) {
              if (provider.isCameraActive) {
                return MobileScanner(
                  onDetect: (barcode) {
                    if (barcode.barcodes.isNotEmpty) {
                      final idTag = barcode.barcodes.first.rawValue;
                      if (idTag != null) {
                        provider.processScannedTag(idTag, classId, courseId);
                      }
                      provider.toggleCamera(); // Ferme la caméra après scan
                    }
                  },
                );
              }

              final tags = provider.filteredTags;

              return Column(
                children: [
                  FilterButtons(
                  ),
                  if (tags.isEmpty)
                    Expanded(
                      child: Center(child: Text('No tags found.')),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: tags.length,
                        itemBuilder: (context, index) {
                          final tag = tags[index];
                          return TagCard(
                            tag: tag,
                            onValidate: (tagId) {
                              provider.validateTag(classId, courseId, tagId, 1);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content: Text('Tag ${tag.name} validated!')),
                              );
                            },
                          );
                        },
                      ),
                    ),
                ],
              );
            },
          );
        },
      ),
      floatingActionButton: Consumer<TagsProvider>(
        builder: (context, provider, child) {
          return FloatingActionButton(
            onPressed: provider.toggleCamera,
            child: Icon(provider.isCameraActive ? Icons.close : Icons.qr_code),
          );
        },
      ),
    );
  }
}
