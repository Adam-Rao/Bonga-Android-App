import 'package:bonga/views/welcome_screen.dart';
import 'package:bonga/views/chat_screen.dart';
import 'package:bonga/views/home_screen.dart';
import 'package:bonga/views/profile_screen.dart';
import 'package:bonga/views/login_screen.dart';
import 'package:bonga/views/registration_screen.dart';
import 'package:bonga/views/settings_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => WelcomeScreen(),
        '/registration': (BuildContext context) => RegistrationScreen(),
        '/login': (BuildContext context) => LoginScreen(),
        '/home': (BuildContext context) => HomeScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
        '/settings': (BuildContext context) => SettingsScreen(),
        '/chat': (BuildContext context) => ChatScreen(),
      },
    );
  }
}
