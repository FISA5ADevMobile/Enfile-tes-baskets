import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/logo_bar.dart';
import '../widgets/section_bar.dart';
import '../widgets/community_tab_bar.dart';
import '../widgets/post_card.dart';
import '../widgets/community_card.dart';
import '../services/community_provider.dart';

class CommunityScreen extends StatefulWidget {
  @override
  _CommunityScreenState createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  int _selectedSectionIndex = 0; // 0 pour "Communauté", 1 pour "Explorer"
  int _selectedTabIndex = 0; // Index de l'onglet sélectionné

  final List<String> _sections = ["Communauté", "Explorer"];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = Provider.of<CommunityProvider>(context, listen: false);
      provider.loadAllCommunities(); // Charger toutes les communautés
    });
  }

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
    });
  }

  void _onSectionSelected(int index) {
    setState(() {
      _selectedSectionIndex = index;
      _selectedTabIndex = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final communityProvider = Provider.of<CommunityProvider>(context);

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
            tabs: _selectedSectionIndex == 0
                ? ["Public"]
                : ["Toutes les communautés"],
            selectedIndex: _selectedTabIndex,
            onTabSelected: _onTabSelected,
          ),
          Expanded(
            child: communityProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : communityProvider.communities.isEmpty
                    ? const Center(
                        child: Text(
                          'Aucune communauté trouvée.',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      )
                    : _selectedSectionIndex == 0
                        ? _buildPostsSection(communityProvider)
                        : _buildCommunitiesSection(communityProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsSection(CommunityProvider communityProvider) {
    if (communityProvider.selectedCommunity?.posts.isEmpty ?? true) {
      return const Center(
        child: Text('Aucun post disponible.'),
      );
    }

    return ListView.builder(
      itemCount: communityProvider.selectedCommunity!.posts.length,
      itemBuilder: (context, index) {
        return PostCard(
            post: communityProvider.selectedCommunity!.posts[index]);
      },
    );
  }

  Widget _buildCommunitiesSection(CommunityProvider communityProvider) {
    return ListView.builder(
      itemCount: communityProvider.communities.length,
      itemBuilder: (context, index) {
        return CommunityCard(
          community: communityProvider.communities[index],
        );
      },
    );
  }
}
