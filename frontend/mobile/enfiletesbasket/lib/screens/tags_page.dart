import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/widgets/custom_app_bar.dart';
import 'package:enfiletesbasket/widgets/custom_bottom_navigation_bar.dart';
import '../services/auth_provider.dart';
import '../services/tags_provider.dart';
import '../widgets/filter_buttons.dart';
import '../widgets/tag_card.dart';
import 'main_navigation_page.dart';

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
      appBar: CustomAppBar(
        showBackButton: true,
        onBackButtonPressed: null,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.refresh,
              color: Color(0xFF49454F),
              size: 28,
            ),
            onPressed: () {
              final String token = authProvider.token ?? '';
              tagsProvider.resetTags(courseId, token);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Balises réinitialisées avec succès !'),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<void>(
        future: () async {
          final String token = authProvider.token ?? '';
          return tagsProvider.fetchTags(classId, courseId, token);
        }(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Une erreur s\'est produite : ${snapshot.error}'));
          }

          return Consumer<TagsProvider>(
            builder: (context, provider, child) {
              if (provider.isCameraActive) {
                return MobileScanner(
                  onDetect: (barcode) {
                    if (barcode.barcodes.isNotEmpty) {
                      final idTag = barcode.barcodes.first.rawValue;
                      if (idTag != null) {
                        provider.onTagScanned(context, int.parse(idTag), courseId);
                      }
                      provider.toggleCamera();
                    }
                  },
                );
              }

              final tags = provider.filteredTags;

              return Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16.0),
                    child: Text(
                      'Parcours d’orientation',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0081A1),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: FilterButtons(),
                  ),
                  if (tags.isEmpty)
                    const Expanded(
                      child: Center(child: Text('Aucune balise trouvée.')),
                    )
                  else
                    Expanded(
                      child: ListView.builder(
                        itemCount: tags.length,
                        itemBuilder: (context, index) {
                          final tag = tags[index];
                          return TagCard(
                            tag: tag,
                            courseId: courseId,
                            onValidate: tag.validated,
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
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          tagsProvider.toggleCamera();
        },
        backgroundColor: const Color(0xFF0081A1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(40),
        ),
        child: Consumer<TagsProvider>(
          builder: (context, provider, child) {
            return Icon(
              provider.isCameraActive ? Icons.close : Icons.qr_code,
              size: 36,
              color: Colors.white,
            );
          },
        ),
        elevation: 8,
        tooltip: 'Scanner une balise',
      ),

      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 2,
        onTap: (index) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => MainNavigationPage(initialIndex: index),
              ),
            );
        },
      ),
    );
  }
}
