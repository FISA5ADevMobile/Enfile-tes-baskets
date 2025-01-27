import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/post.dart';
import '../services/post_provider.dart';

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Text(
                    post.username.isNotEmpty
                        ? post.username[0].toUpperCase()
                        : "?",
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  post.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  post.datePost != null
                      ? "${post.datePost!.day.toString().padLeft(2, '0')}/${post.datePost!.month.toString().padLeft(2, '0')}/${post.datePost!.year}"
                      : "Date inconnue",
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              post.content,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8),
            if (post.imageUrl != null && post.imageUrl!.isNotEmpty)
              Image.network(
                post.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.broken_image,
                      size: 100, color: Colors.grey);
                },
              )
            else
              const SizedBox.shrink(), // Ne rien afficher si aucune image
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: const Icon(Icons.comment),
                  onPressed: () {
                    // Ajouter la logique pour commenter
                  },
                ),
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.thumb_up),
                      color: Colors.blue,
                      onPressed: () async {
                        final provider =
                            Provider.of<PostProvider>(context, listen: false);
                        try {
                          await provider.likePost(post.id);
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text('Post aimé avec succès!')),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(
                                    'Erreur lors de l\'ajout du like: $e')),
                          );
                        }
                      },
                    ),
                    Text(post.nbLike?.toString() ?? "0"), // Nombre de likes
                  ],
                ),
                IconButton(
                  icon: const Icon(Icons.share),
                  onPressed: () {
                    // Ajouter la logique pour partager
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
