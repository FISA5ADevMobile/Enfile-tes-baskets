import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/services/classes_provider.dart';
import 'package:enfiletesbasket/services/tags_provider.dart';
import 'package:enfiletesbasket/services/course_provider.dart';
import 'package:enfiletesbasket/services/actuality_provider.dart';
import 'package:enfiletesbasket/app_routes.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/community_screen.dart';

Future<void> main() async {
  // Sélection du fichier .env en fonction d'un argument
  // const String env = String.fromEnvironment('ENV', defaultValue: 'development'); // Par défaut en dev
  const String env = String.fromEnvironment('ENV');

  print('Environnement: $env');

  // await dotenv.load(fileName: '.env.$env');
  await dotenv.load(fileName: '.env');
  WidgetsFlutterBinding.ensureInitialized();

  final authProvider = AuthProvider();
  await authProvider.autoLogin();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => authProvider),
        ChangeNotifierProvider(create: (_) => ClassesProvider()),
        ChangeNotifierProvider(create: (_) => TagsProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
        ChangeNotifierProvider(create: (_) => ActualityProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return MaterialApp(
          title: 'Enfile tes Baskets',
          theme: ThemeData(
            primaryColor: const Color(0xFF0081A1),
            scaffoldBackgroundColor: Colors.white,
            textTheme: GoogleFonts.montserratTextTheme(),
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: authProvider.isAuthenticated
              ? AppRoutes.mainNavigation
              : AppRoutes.login,
          routes: AppRoutes.getRoutes(),
        );
      },
    );
  }
}
