import 'package:flutter/material.dart';
import 'package:phintraco_assesment/screens/absen/absensi_screen.dart';
import 'package:phintraco_assesment/screens/auth/login_screen.dart';
import 'package:phintraco_assesment/screens/auth/register_screen.dart';
import 'package:phintraco_assesment/screens/bottom_nav/bottom_nav_screen.dart';
import 'package:phintraco_assesment/screens/splash/splashscreen.dart';

class AppRouter {
  Route onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case '/login':
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case '/register':
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case '/home':
        return MaterialPageRoute(builder: (_) => const BottomNavScreen());
      case '/absen':
        return MaterialPageRoute(builder: (_) => const AbsensiScreen());
      default:
        return _routeError();
    }
  }

  static Route _routeError() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: '/error'),
        builder: (_) => Scaffold(
              appBar: AppBar(
                title: const Text('Error'),
              ),
              body: const Center(
                child: Text("Something went wrong!"),
              ),
            ));
  }
}
