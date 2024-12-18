import 'package:flutter/material.dart';

class PageTemplate extends StatelessWidget {
  final Color color;
  final String text;

  const PageTemplate({required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}
