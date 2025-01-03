import 'package:flutter/material.dart';

class CommunitiesPage extends StatelessWidget {
  const CommunitiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text(
          'Page des communautés',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}