
import 'package:enfiletesbasket/screens/MainNavigationPage.dart';
import 'package:enfiletesbasket/services/CourseProvider.dart';
import 'package:enfiletesbasket/services/classes_provider.dart';
import 'package:enfiletesbasket/services/tags_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// Déclarez la clé globale
final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClassesProvider()),
        ChangeNotifierProvider(create: (_) => TagsProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Enfile Tes Baskets',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      scaffoldMessengerKey: scaffoldMessengerKey, // Ajout de la clé globale
      home: const MainNavigationPage(),
    );
  }
}