import 'package:flutter/material.dart';
import 'classes_page.dart';
import 'communities_page.dart';
import 'home_page.dart';
import 'actuality_details_screen.dart';
import '../widgets/custom_bottom_navigation_bar.dart';
import '../widgets/custom_app_bar.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  /// Méthode statique pour naviguer vers les détails d'une actualité
  static void navigateToActualityDetails(BuildContext context, int actualityId) {
    final state = context.findAncestorStateOfType<_MainNavigationPageState>();
    state?._showActualityDetails(actualityId);
  }

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;
  int? _selectedActualityId; // Stocke l'ID de l'actualité sélectionnée

  /// Liste des écrans pour la navigation
  final List<Widget> _screens = [
    const HomePage(),
    const CommunitiesPage(),
    ClassesPage(),
  ];

  /// Fonction pour gérer le changement d'onglet
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedActualityId = null; // Réinitialise l'ID lorsqu'on change d'onglet
    });
  }

  /// Fonction pour afficher la page de détails d'une actualité
  void _showActualityDetails(int actualityId) {
    setState(() {
      _selectedActualityId = actualityId; // Indique l'affichage de la page détail
    });
  }

  /// Détermine si le bouton retour doit être affiché
  bool _shouldShowBackButton() {
    return _selectedIndex != 0 || _selectedActualityId != null;
  }

  /// Récupère l'écran à afficher
  Widget _getCurrentScreen() {
    if (_selectedActualityId != null) {
      return ActualityDetailPage(actualityId: _selectedActualityId!);
    } else {
      return _screens[_selectedIndex];
    }
  }

  /// Récupère l'index actuel pour la navigation
  int _getCurrentNavigationIndex() {
    if (_selectedActualityId != null) {
      return 0; // Maintient l'index sur Home même en détail
    }
    return _selectedIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        showBackButton: _shouldShowBackButton(),
        onBackButtonPressed: () {
          setState(() {
            if (_selectedActualityId != null) {
              _selectedActualityId = null;
            } else {
              _selectedIndex = 0;
            }
          });
        },
        onPersonIconPressed: () {
          print('Icône de profil cliquée');
        },
      ),
      body: _getCurrentScreen(),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _getCurrentNavigationIndex(),
        onTap: _onItemTapped,
      ),
    );
  }
}
