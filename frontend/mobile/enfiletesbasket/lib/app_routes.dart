import 'package:flutter/material.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:enfiletesbasket/screens/register_screen.dart';
import 'package:enfiletesbasket/screens/reset_password_screen.dart';
import 'package:enfiletesbasket/screens/main_navigation_page.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String resetPassword = '/reset-password';
  static const String mainNavigation = '/main-navigation';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      resetPassword: (context) => const ResetPassword(),
      mainNavigation: (context) => const MainNavigationPage(),
    };
  }
}
