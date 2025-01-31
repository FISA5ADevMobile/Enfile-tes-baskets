import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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

  Future<void> _fetchData(BuildContext context) async {
    Future.delayed(Duration.zero, () async {
      final communityProvider =
          Provider.of<CommunityProvider>(context, listen: false);
      final postProvider = Provider.of<PostProvider>(context, listen: false);

      await communityProvider.loadAllCommunities();
      await postProvider.loadAllPosts(); // Charger les posts publics
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
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (_selectedSectionIndex == 0 && _selectedTabIndex == 0) {
            _showCreatePostDialog(context, null);
          } else if (_selectedSectionIndex == 0) {
            final communityProvider =
                Provider.of<CommunityProvider>(context, listen: false);
            _showCreatePostDialog(
                context, communityProvider.selectedCommunity?.id);
          } else {
            _showCreateCommunityDialog(context);
          }
        },
        child: const Icon(Icons.add),
        tooltip: _selectedSectionIndex == 0
            ? "Créer un post"
            : "Créer une communauté",
      ),
      body: FutureBuilder<void>(
        future: _fetchData(context),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Erreur: ${snapshot.error}'));
          }

          return Consumer2<CommunityProvider, PostProvider>(
            builder: (context, communityProvider, postProvider, child) {
              return Column(
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
                            ...communityProvider.communities
                                .map((c) => c.name)
                                .toList()
                          ]
                        : ["Toutes les communautés"],
                    selectedIndex: _selectedTabIndex,
                    onTabSelected: (index) {
                      _onTabSelected(index);
                      if (index > 0 && _selectedSectionIndex == 0) {
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
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildPostsSection(
      PostProvider postProvider, CommunityProvider communityProvider) {
    if (_selectedTabIndex == 0) {
      if (postProvider.posts.isEmpty) {
        return const Center(child: Text('Aucun post disponible.'));
      }
      return ListView.builder(
        itemCount: postProvider.posts.length,
        itemBuilder: (context, index) {
          return PostCard(post: postProvider.posts[index]);
        },
      );
    } else {
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
    if (communityProvider.communities.isEmpty) {
      return const Center(child: Text('Aucune communauté trouvée.'));
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

  void _showCreatePostDialog(BuildContext context, int? communityId) {
    final descriptionController = TextEditingController();
    File? selectedImage;
    String? base64Image;

    Future<void> _pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        setState(() {
          selectedImage = File(pickedFile.path);
        });
        List<int> imageBytes = await selectedImage!.readAsBytes();
        base64Image = base64Encode(imageBytes);
      } else {
        base64Image = null;
      }
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
              "Publier un post ${communityId == null ? 'public' : 'dans une communauté'}"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: "Contenu du post"),
                maxLines: 3,
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Publier une photo"),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("Annuler"),
            ),
            ElevatedButton(
              onPressed: () async {
                final postProvider =
                    Provider.of<PostProvider>(context, listen: false);
                final communityProvider =
                    Provider.of<CommunityProvider>(context, listen: false);

                final postData = {
                  'description': descriptionController.text,
                  'image': base64Image,
                  'visible': true,
                  'relatedPostId': null,
                };

                if (communityId == null) {
                  await postProvider.createPost(postData);
                } else {
                  await communityProvider.createPostInCommunity(
                      communityId, postData);
                }

                Navigator.of(context).pop();
                _fetchData(context);
              },
              child: const Text("Publier le post"),
            ),
          ],
        );
      },
    );
  }

  void _showCreateCommunityDialog(BuildContext context) {
    final nameController = TextEditingController();
    final descriptionController = TextEditingController();
    File? selectedImage;
    String? base64Image;

    Future<void> _pickImage() async {
      final pickedFile =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        selectedImage = File(pickedFile.path);
        List<int> imageBytes = await selectedImage!.readAsBytes();
        base64Image = base64Encode(imageBytes);
      } else {
        base64Image = null; // Si aucune image n'est sélectionnée, envoyer null
      }
    }

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
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.image),
                label: const Text("Publier une image"),
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
                final communityProvider =
                    Provider.of<CommunityProvider>(context, listen: false);

                final communityData = {
                  'nom': nameController.text,
                  'description': descriptionController.text,
                  'isPublic': true,
                  'image': base64Image, // Null si pas d'image sélectionnée
                  'categoryId': null,
                };

                communityProvider.createCommunity(communityData);
                _fetchData(context); // Rafraîchir les données après création
                Navigator.of(context).pop();
              },
              child: const Text("Créer la communauté"),
            ),
          ],
        );
      },
    );
  }
}
