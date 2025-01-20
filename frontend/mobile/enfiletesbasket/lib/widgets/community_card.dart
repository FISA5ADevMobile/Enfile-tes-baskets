import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/community_provider.dart';
import '../models/community.dart';

class CommunityCard extends StatelessWidget {
  final Community community;

  CommunityCard({required this.community});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CommunityProvider>(context, listen: false);

    return Card(
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              community.name,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(community.description),
            const SizedBox(height: 8),
            if (!community.joined)
              ElevatedButton(
                onPressed: () async {
                  try {
                    await provider.joinCommunity(community.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                          content: Text('Vous avez rejoint la communauté.')),
                    );
                  } catch (e) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Erreur: $e')),
                    );
                  }
                },
                child: const Text('Rejoindre'),
              )
            else
              const Text(
                'Vous êtes membre',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}
