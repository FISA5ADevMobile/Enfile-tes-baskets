import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final double? width;
  final bool isDisabled; // Ajout pour griser le bouton lorsqu'il est désactivé

  const PrimaryButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.width,
    this.isDisabled = false, // Par défaut, le bouton est actif
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      child: ElevatedButton(
        onPressed: isDisabled ? null : onPressed, // Désactive complètement le bouton
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50.0),
          ),
          backgroundColor: isDisabled
              ? Colors.grey.shade400 // Couleur grise lorsqu'il est désactivé
              : const Color(0xFF0081A1), // Couleur normale
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            color: isDisabled ? Colors.grey.shade700 : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
