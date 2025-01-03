import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/actuality_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/custom_popup.dart';

class ActualityDetailPage extends StatefulWidget {
  final int actualityId;

  const ActualityDetailPage({Key? key, required this.actualityId}) : super(key: key);

  @override
  _ActualityDetailPageState createState() => _ActualityDetailPageState();
}

class _ActualityDetailPageState extends State<ActualityDetailPage> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ActualityProvider>(context, listen: false);
      provider.loadActualityById(widget.actualityId);
      provider.checkIfSubscribed(widget.actualityId); // Vérifie si l'utilisateur est inscrit
    });
  }

  /// ✅ Affiche une popup de confirmation ou d'erreur
  void _showPopup(String title, String description, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        title: title,
        description: description,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  /// ✅ Gère l'inscription à l'événement
  Future<void> _handleSubscription() async {
    final provider = Provider.of<ActualityProvider>(context, listen: false);

    try {
      await provider.subscribeToEvent(widget.actualityId);
      _showPopup(
        'Inscription réussie',
        'Vous êtes maintenant inscrit à cet événement.',
      );
    } catch (e) {
      _showPopup(
        'Erreur',
        'Une erreur est survenue lors de l\'inscription. Veuillez réessayer.',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final actualityProvider = Provider.of<ActualityProvider>(context);

    return Scaffold(
      body: actualityProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : actualityProvider.selectedActuality == null
          ? const Center(
        child: Text(
          'Aucune actualité trouvée.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : Column(
        children: [
          /// 📸 **Image Section avec marge et bords arrondis**
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Image.memory(
                actualityProvider.selectedActuality!.imageBytes,
                fit: BoxFit.contain,
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
                      actualityProvider.selectedActuality!.title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      actualityProvider.selectedActuality!.description,
                      style: const TextStyle(fontSize: 16),
                      textAlign: TextAlign.justify,
                    ),
                    const SizedBox(height: 24),

                    /// 🎟️ **Bouton d'inscription à l'événement**
                    if (actualityProvider.selectedActuality!.isEvent)
                      Center(
                        child: PrimaryButton(
                          text: actualityProvider.isSubscribed
                              ? "Déjà inscrit à l'événement"
                              : "Participer à l'événement",
                          onPressed: actualityProvider.isSubscribed
                              ? null
                              : _handleSubscription,
                          width: double.infinity,
                          isDisabled: actualityProvider.isSubscribed,
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
                "Publiée le ${actualityProvider.selectedActuality!.publicationDate.day.toString().padLeft(2, '0')}/${actualityProvider.selectedActuality!.publicationDate.month.toString().padLeft(2, '0')}/${actualityProvider.selectedActuality!.publicationDate.year}",
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
