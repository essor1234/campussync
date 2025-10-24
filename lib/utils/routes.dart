import 'package:campussync/screens/event/events_screen.dart';
import 'package:campussync/screens/schedule/schedule_screen.dart';
import 'package:flutter/material.dart';
import '../screens/auth/login_screen.dart';
import '../screens/auth/register_screen.dart';
import '../screens/aiAgent/smart_screen.dart';
import '../screens/home/home_screen.dart';
// import other screens later (home, dashboard, etc.)

class Routes {
  static const String login = '/login';
  static const String register = '/register';
  static const String events = '/events';
  static const String schedule = '/schedule';
  static const String home = '/home';
  static const String study = '/study';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => RegisterScreen());
      case events:
        return MaterialPageRoute(builder: (_) => const EventScreen());
      case schedule:
        return MaterialPageRoute(builder: (_) => const ScheduleScreen());
      case study:
        return MaterialPageRoute(builder: (_) => const StudySmartScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) =>
              const Scaffold(body: Center(child: Text('Page not found'))),
        );
    }
  }
}
