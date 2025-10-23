import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/user_provider.dart';
import 'utils/routes.dart';
import 'screens/auth/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserProvider()),
        // Add others later
      ],
      child: MaterialApp(
        title: 'School Management',
        theme: ThemeData(primarySwatch: Colors.blue),
        initialRoute: Routes.login,
        onGenerateRoute: Routes.generateRoute,
      ),
    );
  }
}
