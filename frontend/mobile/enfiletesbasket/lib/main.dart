import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enfile tes Baskets',
      theme: ThemeData(
        primaryColor: const Color(0xFF0081A1),
        scaffoldBackgroundColor: Colors.white,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
