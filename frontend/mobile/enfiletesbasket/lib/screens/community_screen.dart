import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/logo_bar.dart';
import '../widgets/section_bar.dart';
import '../widgets/community_tab_bar.dart';
import '../widgets/post_card.dart';
import '../widgets/community_card.dart';
import '../services/community_provider.dart';
import '../services/post_provider.dart';

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
      final communityProvider =
          Provider.of<CommunityProvider>(context, listen: false);
      final postProvider = Provider.of<PostProvider>(context, listen: false);

      communityProvider.loadAllCommunities();
      postProvider.loadAllPosts(); // Charger les posts publics
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
    final postProvider = Provider.of<PostProvider>(context);

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedSectionIndex == 0 && _selectedTabIndex == 0) {
            // Créer un post public
            _showCreatePostDialog(context, postProvider, null);
          } else if (_selectedSectionIndex == 0 &&
              communityProvider.selectedCommunity != null) {
            // Créer un post dans une communauté
            _showCreatePostDialog(
                context, postProvider, communityProvider.selectedCommunity!.id);
          } else {
            // Créer une communauté
            _showCreateCommunityDialog(context, communityProvider);
          }
        },
        child: const Icon(Icons.add),
        tooltip: _selectedSectionIndex == 0
            ? "Créer un post"
            : "Créer une communauté",
      ),
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
                ? [
                    "Public",
                    ...communityProvider.communities.map((c) => c.name).toList()
                  ]
                : ["Toutes les communautés"],
            selectedIndex: _selectedTabIndex,
            onTabSelected: (index) {
              _onTabSelected(index);
              if (index > 0 && _selectedSectionIndex == 0) {
                // Charger les posts de la communauté sélectionnée
                communityProvider.selectCommunity(index - 1);
              }
            },
          ),
          Expanded(
            child: _selectedSectionIndex == 0
                ? _buildPostsSection(postProvider, communityProvider)
                : _buildCommunitiesSection(communityProvider),
          ),
        ],
      ),
    );
  }

  Widget _buildPostsSection(
      PostProvider postProvider, CommunityProvider communityProvider) {
    if (_selectedTabIndex == 0) {
      // Afficher les posts publics
      if (postProvider.isLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (postProvider.posts.isEmpty) {
        return const Center(
          child: Text('Aucun post disponible.'),
        );
      }
      return ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: postProvider.posts[index]);
        },
      );
    } else {
      // Afficher les posts de la communauté sélectionnée
      final selectedCommunity = communityProvider.selectedCommunity;
      if (selectedCommunity == null || selectedCommunity.posts.isEmpty) {
        return const Center(
          child: Text('Aucun post disponible dans cette communauté.'),
        );
      }
      return ListView.builder(
        itemCount: selectedCommunity.posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: selectedCommunity.posts[index]);
        },
      );
    }
  }

  Widget _buildCommunitiesSection(CommunityProvider communityProvider) {
    if (communityProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }
    if (communityProvider.communities.isEmpty) {
      return const Center(
        child: Text('Aucune communauté trouvée.'),
      );
    }
    return ListView.builder(
      itemCount: communityProvider.communities.length,
      itemBuilder: (context, index) {
        return CommunityCard(
          community: communityProvider.communities[index],
        );
      },
    );
  }

  void _showCreatePostDialog(
      BuildContext context, PostProvider postProvider, int? communityId) {
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              "Publier un post ${communityId == null ? 'public' : 'dans la communauté'}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Contenu du post"),
                maxLines: 3,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                final postData = {
                  'description': descriptionController.text,
                  'image': null, // Gestion des images (si applicable)
                  'visible': true,
                  'relatedPostId': null,
                };

                if (communityId == null) {
                  // Publier dans "Public"
                  postProvider.createPost(postData);
                } else {
                  // Publier dans une communauté spécifique
                  final communityProvider =
                      Provider.of<CommunityProvider>(context, listen: false);
                  communityProvider.createPostInCommunity(
                      communityId, postData);
                }

                Navigator.of(context).pop();
              },
              child: const Text("Publier le post"),
            ),
          ],
        );
      },
    );
  }

  void _showCreateCommunityDialog(
      BuildContext context, CommunityProvider communityProvider) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Créer une communauté"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Nom"),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Description"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () {
                communityProvider.createCommunity({
                  'nom': nameController.text,
                  'description': descriptionController.text,
                  'isPublic': true,
                  'image': null,
                  'categoryId': null,
                });
                Navigator.of(context).pop();
              },
              child: const Text("Créer"),
            ),
          ],
        );
      },
    );
  }
}
