import 'package:bonga/views/auth_screen.dart';
import 'package:bonga/views/chat_screen.dart';
import 'package:bonga/views/home_screen.dart';
import 'package:bonga/views/profile_screen.dart';
import 'package:bonga/views/login_screen.dart';
import 'package:bonga/views/registration_screen.dart';
import 'package:bonga/views/settings_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (BuildContext context) => AuthScreen(),
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