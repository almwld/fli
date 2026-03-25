import 'package:flutter/material.dart';
import 'package:flex_yemen/screens/auth/splash_screen.dart';
import 'package:flex_yemen/screens/auth/login_screen.dart';
import 'package:flex_yemen/screens/auth/register_screen.dart';
import 'package:flex_yemen/screens/home/main_navigation.dart';

class AppRoutes {
  static const String splash = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String mainNavigation = '/main_navigation';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case mainNavigation:
        return MaterialPageRoute(builder: (_) => const MainNavigation());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('لا توجد مسار محدد لـ ${settings.name}'),
            ),
          ),
        );
    }
  }
}
