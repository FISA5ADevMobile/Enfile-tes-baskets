import 'package:enfiletesbasket/home_page.dart';
import 'package:flutter/material.dart';
import 'page_template.dart';

class CarouselPage extends StatefulWidget {
  @override
  _CarouselPageState createState() => _CarouselPageState();
}

class _CarouselPageState extends State<CarouselPage> {
  final PageController _pageController = PageController(initialPage: 0);
  int _currentIndex = 1;

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _onBottomBarTap(int index) {
    setState(() {
      _currentIndex = index;
    });

    _pageController.animateToPage(index,
        duration: Duration(milliseconds: 300), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white, // Fond blanc
          elevation: 2, // Ombre légère sous la topBar
          shadowColor:
              Colors.black.withOpacity(0.5), // Couleur de l'ombre (optionnelle)
          title: Row(
            children: [
              // Leading icon
              IconButton(
                icon: const Icon(Icons.person),
                onPressed: () {
                  // Action pour le bouton leading
                },
              ),
              // Espace pour centrer le logo
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/Images/app-logo.png', // Remplacez par le chemin de votre logo
                    height: 40, // Ajustez la hauteur selon vos besoins
                  ),
                ),
              ),
              // Espace vide pour équilibrer le Row
              const SizedBox(width: 48), // Ajustez la largeur selon vos besoins
            ],
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: _onPageChanged,
          children: [
            HomePage(),
            PageTemplate(color: Colors.orange, text: 'CommunityPage'),
            PageTemplate(color: Colors.red, text: 'ParkourPage'),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomBarTap,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Accueil',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_right),
              label: 'Communautés',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.arrow_right),
              label: 'Parcours',
            ),
          ],
        ));
  }
}
