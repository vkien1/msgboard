import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/settings_screen.dart';
import 'theme_provider.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ThemeProvider(
        ThemeData(
          brightness: Brightness.light,
          primaryColor: Color(0xFF1B4D3E),
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: AppBarTheme(
            color: Color(0xFF1B4D3E),
            foregroundColor: Colors.white,
          ),
          textTheme: TextTheme(
            bodyText2: TextStyle(color: Color(0xFF1B4D3E)),
          ),
        ),
      ),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Flutter Task Manager',
            theme: themeProvider.getTheme, 
            initialRoute: '/',
            routes: {
              '/': (context) => LoginScreen(),
              '/homepage': (context) => HomeScreen(),
              '/login': (context) => LoginScreen(),
              '/settings': (context) => SettingsScreen(),
            },
          );
        },
      ),
    );
  }
}
