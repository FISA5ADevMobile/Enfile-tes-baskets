import 'package:enfiletesbasket/screens/main_navigation_page.dart';
import 'package:enfiletesbasket/screens/register_screen.dart';
import 'package:enfiletesbasket/screens/reset_password._screen.dart';
import 'package:enfiletesbasket/services/course_provider.dart';
import 'package:enfiletesbasket/services/classes_provider.dart';
import 'package:enfiletesbasket/services/tags_provider.dart';

import 'package:provider/provider.dart';
import 'package:enfiletesbasket/services/auth_provider.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:google_fonts/google_fonts.dart';
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => ClassesProvider()),
        ChangeNotifierProvider(create: (_) => TagsProvider()),
        ChangeNotifierProvider(create: (_) => CourseProvider()),
      ],
      child: MyApp(),
    ),
  );

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
        '/main-navigation': (context) => const MainNavigationPage(),
      },
    );
  }
}

