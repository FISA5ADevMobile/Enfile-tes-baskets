import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Bienvenue à nouveau sur Enfile Tes Baskets !',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Contente de te revoir ! Prêt.e à reprendre là où tu t’étais arrêté.e ? 💪',
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              'Retrouve les dernières actualités, connecte-toi avec tes communautés ou pars pour une nouvelle aventure !',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}