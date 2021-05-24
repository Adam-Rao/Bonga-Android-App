import 'package:bonga/views/AuthScreen.dart';
import 'package:bonga/views/HomeScreen.dart';
import 'package:bonga/views/ProfileScreen.dart';
import 'package:bonga/views/LoginScreen.dart';
import 'package:bonga/views/RegistrationScreen.dart';
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
      },
    );
  }
}