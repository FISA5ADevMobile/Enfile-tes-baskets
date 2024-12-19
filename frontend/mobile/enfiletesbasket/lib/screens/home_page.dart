import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../widgets/actuality_card.dart';
import '../widgets/custom_app_bar.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Simuler des actualités
  final List<Map<String, dynamic>> _mockedActivities = [
    {
      'title': 'Enfile Tes Baskets : Nouveau Parcours',
      'description': 'Découvrez le dernier parcours dans votre communauté locale !',
      'image': 'assets/images/logo_enfiletesbaskets_fondbleu.png',
      'isEvent': true,
    },
    {
      'title': 'Challenge Running',
      'description': 'Participez à notre challenge running de ce mois-ci et gagnez des récompenses !',
      'image': 'assets/images/logo_enfiletesbaskets_fondbleu.png',
      'isEvent': false,
    },
    {
      'title': 'Conseils Running',
      'description': 'Améliorez votre technique de course grâce à nos astuces de pros.',
      'image': 'assets/images/logo_enfiletesbaskets_fondbleu.png',
      'isEvent': false,
    },
  ];

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Fond blanc de la page
      appBar: CustomAppBar(
        onPersonIconPressed: () {
          print('Icone de profil cliquée');
        },
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Bienvenue à nouveau sur Enfile Tes Baskets !',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Content de te revoir ! Prêt.e à reprendre là où tu t’étais arrêté.e ? 💪',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text(
              'Actualités',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
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
            itemCount: _mockedActivities.length,
            itemBuilder: (context, index, realIndex) {
              final activity = _mockedActivities[index];
              return ActualityCard(
                title: activity['title'],
                description: activity['description'],
                image: activity['image'],
                isEvent: activity['isEvent'],
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _mockedActivities.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => setState(() {
                  _currentIndex = entry.key;
                }),
                child: Container(
                  width: 12.0,
                  height: 12.0,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
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
        ],
      ),
    );
  }
}
