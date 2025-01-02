import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/actuality_provider.dart';
import '../models/actuality.dart';

class ActualityDetailPage extends StatelessWidget {
  final int actualityId;

  const ActualityDetailPage({Key? key, required this.actualityId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<Actuality?>(
        future: Provider.of<ActualityProvider>(context, listen: false)
            .loadActualityById(actualityId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Erreur: ${snapshot.error}',
                style: const TextStyle(color: Colors.red),
              ),
            );
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(
              child: Text(
                'Aucune actualité trouvée.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }

          final actuality = snapshot.data!;

          return Column(
            children: [
              /// 📸 **Image Section avec marge et bords arrondis**
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0), // Arrondi des bords
                  child: Image.memory(
                    actuality.imageBytes,
                    fit: BoxFit.contain, // L'image s'affiche complètement
                    width: double.infinity,
                  ),
                ),
              ),

              const SizedBox(height: 24),

              /// 📝 **Title and Description Section**
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          actuality.title,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          actuality.description,
                          style: const TextStyle(fontSize: 16),
                          textAlign: TextAlign.justify,
                        ),
                        const SizedBox(height: 24),
                        if (actuality.isEvent)
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                print("Bouton d'événement cliqué");
                              },
                              child: const Text("Participer à l'événement"),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              /// 📅 **Publication Date Section**
              Padding(
                padding: const EdgeInsets.only(
                  right: 16.0,
                  bottom: 16.0,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Text(
                    "Publiée le ${actuality.publicationDate.day.toString().padLeft(2, '0')}/${actuality.publicationDate.month.toString().padLeft(2, '0')}/${actuality.publicationDate.year}",
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
