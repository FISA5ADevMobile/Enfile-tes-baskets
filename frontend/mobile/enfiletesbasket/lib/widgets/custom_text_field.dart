import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? borderColor; // Nouvelle propriété pour la bordure

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.borderColor, // Ajout
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor ?? const Color(0xFFE8E8E8), // Défaut ou rouge
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor ?? const Color(0xFFE8E8E8), // Défaut ou rouge
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: borderColor ?? const Color(0xFF0081A1),
          ),
        ),
      ),
    );
  }
}