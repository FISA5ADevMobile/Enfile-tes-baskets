
import 'package:flutter/material.dart';

import 'ClassesPage.dart';
import 'CommunitiesPage.dart';
import 'HomePage.dart';

class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  _MainNavigationPageState createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  // List of screens for navigation
  final List<Widget> _screens = [
    const HomePage(),
    const CommunitiesPage(),
    ClassesPage(), // Directement utilisé sans Provider ici
  ];

  // Function to handle navigation
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex], // Display the selected screen
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Communautés',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Parcours',
          ),
        ],
      ),
    );
  }
}