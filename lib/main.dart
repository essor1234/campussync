// main.dart
import 'package:campussync/providers/chat_provider.dart';
import 'package:campussync/providers/user_provider.dart';
import 'package:campussync/providers/schedule_provider.dart';
import 'package:campussync/providers/event_provider.dart';
import 'package:campussync/screens/auth/login_screen.dart';
import 'package:campussync/screens/auth/register_screen.dart';
import 'package:campussync/screens/event/events_screen.dart';
import 'package:campussync/screens/home/home_screen.dart';
import 'package:campussync/screens/schedule/schedule_screen.dart';
import 'package:campussync/screens/aiAgent/smart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:campussync/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env (must be in project root + listed in pubspec.yaml assets)
  await dotenv.load(fileName: ".env");

  runApp(const MyApp());
}

// (Optional) keep a global reference – not needed for the test
// final apiKey = dotenv.env['PERPLEXITY_API_KEY'];

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => ScheduleProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CampusSync', // Updated to match your app name
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),
        // Remove the 'routes' map to avoid conflicts—rely on onGenerateRoute for all
        // **TESTING** – uncomment if you want to bypass auth temporarily
        // home: const StudySmartScreen(),  // Or HomeScreen() for full flow

        // Standard auth flow: Start at login, auto-redirect if already logged in
        home: Consumer<UserProvider>(
          builder: (context, userProvider, child) {
            if (userProvider.user != null) {
              return const HomeScreen();
            }
            return const LoginScreen();
          },
        ),
        onGenerateRoute: Routes
            .generateRoute, // Handles all named routes (login, home, etc.)
      ),
    );
  }
}
