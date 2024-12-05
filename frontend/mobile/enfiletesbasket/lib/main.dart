import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MyApp(),
    ),
  );
}

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
