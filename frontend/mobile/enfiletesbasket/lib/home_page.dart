import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Bienvenue à nouveau sur Enfile Tes Baskets !',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Content de te revoir ! Prêt.e à reprendre là où tu t’étais arrêté.e ? 💪',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Retrouve les dernières actualités, connecte-toi avec tes communautés ou pars pour une nouvelle aventure !',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'À tes baskets, c’est parti ! 🏃‍♀️🏃‍♂️',
              style: TextStyle(fontSize: 16),
            ),
          ),
          const SizedBox(height: 20),
          const Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              'Actualités',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 450, // Hauteur fixe pour la ListView horizontale
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 10, // Par exemple, 10 éléments
              itemBuilder: (context, index) {
                var item = {
                  'title': 'Titre de l\'élément $index',
                  'description':
                      'Ceci est une description de l\'élément $index.',
                  'image': 'assets/app-logo.png',
                };
                return Container(
                  width: 500, // Largeur fixe pour chaque élément
                  margin:
                      const EdgeInsets.symmetric(horizontal: 8.0), // Espacement
                  child: Card(
                    elevation: 4, // Ombre pour l'effet visuel
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 300,
                            child: Image.asset(
                              item['image']!,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            item['title']!,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            item['description']!,
                            maxLines: 3, // Limite à 2 lignes
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
