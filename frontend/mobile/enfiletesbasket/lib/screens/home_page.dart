import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';
import '../services/actuality_provider.dart';
import '../utils/text_utils.dart'; // Pour le décodage
import '../widgets/actuality_card.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<ActualityProvider>(context, listen: false).loadActualities();
    });
  }

  @override
  Widget build(BuildContext context) {
    final actualityProvider = Provider.of<ActualityProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        onPersonIconPressed: () {
          print('Icone de profil cliquée');
        },
      ),
      body: actualityProvider.isLoading
          ? const Center(child: CircularProgressIndicator())
          : actualityProvider.actualities.isEmpty
          ? const Center(
        child: Text(
          'Aucune actualité disponible.',
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      )
          : Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32), // Espacement sous l'AppBar
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Bienvenue à nouveau sur Enfile Tes Baskets !',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 16), // Espacement sous le texte de bienvenue
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Content de te revoir ! Prêt.e à reprendre là où tu t’étais arrêté.e ? 💪',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 40), // Espacement avant "Actualités"
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Actualités',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24), // Espacement avant le carrousel
          CarouselSlider.builder(
            options: CarouselOptions(
              height: 400, // Hauteur du carrousel
              autoPlay: false,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            itemCount: actualityProvider.actualities.length,
            itemBuilder: (context, index, realIndex) {
              final actuality = actualityProvider.actualities[index];
              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8.0,
                ), // Marges autour des cartes
                child: ActualityCard(
                  title: decodeText(actuality.title),
                  description: decodeText(actuality.description),
                  imageBytes: actuality.imageBytes,
                  isEvent: actuality.isEvent,
                ),
              );
            },
          ),
          const SizedBox(height: 12), // Espacement avant les indicateurs
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: actualityProvider.actualities
                .asMap()
                .entries
                .map((entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = entry.key;
                }),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentIndex == entry.key
                        ? const Color(0xFF49454F) // Couleur active
                        : const Color(0xFFD8D8D8), // Couleur inactive
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 24), // Espacement final après les indicateurs
        ],
      ),
    );
  }
}
