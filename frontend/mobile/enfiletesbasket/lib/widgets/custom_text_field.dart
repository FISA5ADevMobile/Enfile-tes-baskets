import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController? controller;
  final Color? borderColor;
  final String obscuringCharacter;
  final Duration obscureTextDelay;

  const CustomTextField({
    Key? key,
    required this.labelText,
    this.obscureText = false,
    this.controller,
    this.borderColor,
    this.obscuringCharacter = '•',
    this.obscureTextDelay = const Duration(milliseconds: 500),
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  void _onTextChanged(String value) {
    if (value.isNotEmpty && widget.obscureText) {
      setState(() {
      });

      Future.delayed(widget.obscureTextDelay, () {
        setState(() {
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: _obscureText,
      keyboardType: widget.obscureText
          ? TextInputType.visiblePassword
          : TextInputType.emailAddress,
      onChanged: _onTextChanged,
      decoration: InputDecoration(
        labelText: widget.labelText,
        filled: true,
        fillColor: const Color(0xFFF6F6F6),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widget.borderColor ?? const Color(0xFFE8E8E8),
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widget.borderColor ?? const Color(0xFFE8E8E8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: widget.borderColor ?? const Color(0xFF0081A1),
          ),
        ),
      ),
      style: TextStyle(
        letterSpacing: widget.obscureText ? 1.5 : null,
      ),
    );
  }
}
