import 'package:enfiletesbasket/screens/reset_password_screen.dart';
import 'package:flutter/material.dart';
import 'package:enfiletesbasket/screens/login_screen.dart';
import 'package:enfiletesbasket/screens/register_screen.dart';
import 'package:enfiletesbasket/screens/request_reset_password_screen.dart';
import 'package:enfiletesbasket/screens/main_navigation_page.dart';
import 'package:enfiletesbasket/screens/actuality_details_screen.dart';

class AppRoutes {
  static const String login = '/login';
  static const String register = '/register';
  static const String requestResetPassword = '/request-reset-password';
  static const String resetPassword = '/reset-password';
  static const String mainNavigation = '/main-navigation';
  static const String actualityDetails = '/actuality-details';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      login: (context) => const LoginScreen(),
      register: (context) => const RegisterScreen(),
      requestResetPassword: (context) => const RequestResetPassword(),
      resetPassword: (context) => const ResetPassword(),
      mainNavigation: (context) => const MainNavigationPage(),
      actualityDetails: (context) {
        final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
        return ActualityDetailPage(actualityId: args['actualityId']);
      },
    };
  }
}
