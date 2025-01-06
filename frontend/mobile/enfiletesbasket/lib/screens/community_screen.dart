import 'package:flutter/material.dart';
import '../widgets/logo_bar.dart';
import '../widgets/section_bar.dart';
import '../widgets/community_tab_bar.dart';
import '../widgets/post_card.dart';
import '../widgets/community_card.dart';
import '../models/post.dart';
import '../models/community.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedSectionIndex = 0; // 0 pour "Communauté", 1 pour "Explorer"
  int _selectedTabIndex = 0; // Index de l'onglet sélectionné

  final List<String> _communityTabs = [
    "Public",
    "Les nageurs fous",
    "Les coureurs du valenciennois",
  ];

  final List<String> _explorerTabs = [
    "Natation",
    "Cyclisme",
    "Running",
  ];

  final List<String> _sections = [
    "Communauté",
    "Explorer",
  ];

  // Faux posts pour la section "Communauté"
  final List<Post> _posts = [
    Post(username: "Utilisateur1", time: "2h", content: "C'est un super jour pour nager !", imageUrl: "https://via.placeholder.com/150"),
    Post(username: "Utilisateur2", time: "1h", content: "J'adore courir le matin.", imageUrl: "https://via.placeholder.com/150"),
  ];

  // Fausses communautés pour la section "Explorer"
  final List<Community> _communities = [
    Community(
        name: "Les nageurs fous",
        description: 'communauté de nageurs',
        image: 'https://www.produits-laitiers.com/app/uploads/2019/12/adobestock_119006957-1085x695.jpeg'
    ),
    Community(
        name: "Les cyclistes",
        description: 'communauté de cyclistes',
        image: 'https://img.centrefrance.com/0UNeLpWugDiQxzxvrNs3ON5v3YEK51b6SO_CyYbqw_M/rs:fit:657:438:1:0/bG9jYWw6Ly8vMDAvMDAvMDcvMjYvMzIvMjAwMDAwNzI2MzI1NA.webp'
    ),
    Community(
      name: "Les coureurs du valenciennois",
      description: 'communauté de coureur dans le valenciennois',
      image: 'https://www.leparisien.fr/resizer/UVf_vNjh0CR22EyCnaYxIMgPLno=/932x582/cloudfront-eu-central-1.images.arcpublishing.com/leparisien/WKGOZM2M75BLLNM4EHJIWYVPA4.jpg',
    ),
  ];

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index; // Met à jour l'index de l'onglet sélectionné
    });
  }

  void _onSectionSelected(int index) {
    setState(() {
      _selectedSectionIndex = index; // Met à jour l'index de la section sélectionnée
      _selectedTabIndex = 0; // Réinitialise l'onglet sélectionné à 0 lors du changement de section
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          LogoBar(),
          SectionBar(
            sections: _sections,
            selectedIndex: _selectedSectionIndex,
            onSectionSelected: _onSectionSelected,
          ),
          CommunityTabBar(
            tabs: _selectedSectionIndex == 0 ? _communityTabs : _explorerTabs,
            selectedIndex: _selectedTabIndex,
            onTabSelected: _onTabSelected,
          ),
          Expanded(
            child: _selectedSectionIndex == 0
                ? ListView.builder(
              itemCount: _posts.length,
              itemBuilder: (context, index) {
                return PostCard(post: _posts[index]);
              },
            )
                : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    itemCount: _communities.length,
                    itemBuilder: (context, index) {
                      return CommunityCard(community: _communities[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}