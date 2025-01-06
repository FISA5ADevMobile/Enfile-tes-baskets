import 'package:flutter/material.dart';
import '../models/community.dart';

class CommunityCard extends StatefulWidget {
  final Community community;

  CommunityCard({required this.community});

  @override
  _CommunityCardState createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  bool _isJoined = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.community.name),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _isJoined = !_isJoined;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _isJoined ? Color(0xFF0081A1) : Color(0xFFC8A14E)
                ,
              ),
              child: Text(_isJoined ? "Rejoint" : "Rejoindre"),
            ),
          ],
        ),
      ),
    );
  }
}