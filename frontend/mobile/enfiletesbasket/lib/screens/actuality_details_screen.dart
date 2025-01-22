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
  bool _isSubscribing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<ActualityProvider>(context, listen: false);
      provider.loadActualityById(widget.actualityId);
      provider.checkIfSubscribed(widget.actualityId);
    });
  }

  void _showPopup(String title, String description, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (context) => CustomPopup(
        title: title,
        description: description,
        actions: [
          PrimaryButton(
            text: "Ok",
            onPressed: () {
              Navigator.of(context).pop();
            },
            width: 120,
          ),
        ],
      ),
    );
  }

  Future<void> _handleSubscription() async {
    final provider = Provider.of<ActualityProvider>(context, listen: false);

    setState(() {
      _isSubscribing = true;
    });

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
    } finally {
      setState(() {
        _isSubscribing = false;
      });
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: actualityProvider.selectedActuality!.imageBytes.isNotEmpty
                  ? Image.memory(
                actualityProvider.selectedActuality!.imageBytes,
                fit: BoxFit.contain,
                width: double.infinity,
              )
                  : Container(
                color: Colors.grey[200],
                height: 200,
                width: double.infinity,
                child: const Center(
                  child: Icon(
                    Icons.image_not_supported,
                    color: Colors.grey,
                    size: 50,
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

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

                    if (actualityProvider.selectedActuality!.isEvent)
                      Center(
                        child: PrimaryButton(
                          text: actualityProvider.isSubscribed
                              ? "Déjà inscrit à l'événement"
                              : "Participer à l'événement",
                          onPressed: actualityProvider.isSubscribed || _isSubscribing
                              ? null
                              : _handleSubscription,
                          isDisabled: actualityProvider.isSubscribed || _isSubscribing,
                          width: double.infinity,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),

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
