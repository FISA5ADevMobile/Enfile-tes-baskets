import 'package:flutter/material.dart';

class LogoBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      color: Colors.white,
      child: Center(
        child: Image.asset(
          'assets/images/icone_logo_blanc.png',
          height: 80,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}