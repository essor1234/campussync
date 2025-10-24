// main.dart
import 'package:campussync/providers/chat_provider.dart';
import 'package:campussync/screens/event/events_screen.dart';
import 'package:campussync/screens/home/home_screen.dart';
import 'package:campussync/screens/schedule/schedule_screen.dart';
import 'screens/aiAgent/smart_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';

import 'providers/user_provider.dart';
import 'providers/schedule_provider.dart';
import 'providers/event_provider.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load .env (must be in project raíz + listed in pubspec.yaml assets)
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
        title: 'School Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
          ),
        ),

        // **TESTING** – go straight to the AI screen
        home: const HomeScreen(),
        routes: {
          '/study': (context) => const StudySmartScreen(),
          '/events': (context) => const EventScreen(),
          '/schedule': (context) => const ScheduleScreen(),
        },

        // Keep your normal routing for later
        // initialRoute: Routes.login,
        // onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
