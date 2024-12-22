import 'package:enfiletesbasket/screens/MainNavigationPage.dart';
import 'package:enfiletesbasket/screens/register_screen.dart';
import 'package:enfiletesbasket/screens/reset_password._screen.dart';
import 'package:enfiletesbasket/services/CourseProvider.dart';
import 'package:enfiletesbasket/services/classes_provider.dart';
import 'package:enfiletesbasket/services/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/reset-password': (context) => const ResetPassword(),
        '/main-navigation': (context) => MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => ClassesProvider()),
            ChangeNotifierProvider(create: (_) => TagsProvider()),
            ChangeNotifierProvider(create: (_) => CourseProvider()),
          ],
          child: const MainNavigationPage(),
        ),
      },
    );
  }
}

