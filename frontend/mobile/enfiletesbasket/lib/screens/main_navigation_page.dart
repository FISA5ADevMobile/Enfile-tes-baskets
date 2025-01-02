import 'package:flutter/material.dart';
import 'classes_page.dart';
import 'communities_page.dart';
import 'home_page.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_app_bar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  // Liste des écrans pour la navigation
  final List<Widget> _screens = [
    const HomePage(),
    const CommunitiesPage(),
    ClassesPage(),
  ];

  // Fonction pour gérer la navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // Détermine si le bouton retour doit être affiché
  bool _shouldShowBackButton() {
    // Active le bouton retour pour les pages autres que HomePage
    return _selectedIndex != 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: _shouldShowBackButton(),
        onBackButtonPressed: () {
          setState(() {
            _selectedIndex = 0; // Retourne toujours à la HomePage
          });
        },
        onPersonIconPressed: () {
          print('Icone de profil cliquée');
        },
      ),
      body: _screens[_selectedIndex], // Affiche l'écran sélectionné
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
