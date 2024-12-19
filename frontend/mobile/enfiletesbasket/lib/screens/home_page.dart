import 'package:flutter/material.dart';
import '../widgets/activity_card.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        onPersonIconPressed: () {
          // Ajoutez ici une action pour le bouton de l'icône "person", si nécessaire
          print('Person icon pressed');
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
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _mockedActivities.length,
              itemBuilder: (context, index) {
                final activity = _mockedActivities[index];
                return ActivityCard(
                  title: activity['title'],
                  description: activity['description'],
                  image: activity['image'],
                  isEvent: activity['isEvent'],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
