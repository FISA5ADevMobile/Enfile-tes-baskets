import 'package:flutter/material.dart';
import '../models/activity.dart';
import '../services/activity_service.dart';
import '../widgets/activity_card.dart';
import '../widgets/custom_app_bar.dart'; // Import de l'AppBar personnalisée

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<Activity>> _activities;

  @override
  void initState() {
    super.initState();
    _activities = ActivityService().fetchActivities();
  }

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
              'Content de te revoir ! Prêt.e à reprendre là où tu t’étais arrêté.e ? 💪',
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
            child: FutureBuilder<List<Activity>>(
              future: _activities,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Erreur : ${snapshot.error}'),
                  );
                } else if (snapshot.hasData) {
                  final activities = snapshot.data!;
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: activities.length,
                    itemBuilder: (context, index) {
                      return ActivityCard(activity: activities[index]);
                    },
                  );
                } else {
                  return const Center(child: Text('Aucune activité trouvée.'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
