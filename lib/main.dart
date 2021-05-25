import 'package:flutter/material.dart';
import 'package:practica2/src/screens/contact_screen.dart';
import 'package:practica2/src/screens/detail_screen.dart';
import 'package:practica2/src/screens/liked_screen.dart';
import 'package:practica2/src/screens/login.dart';
import 'package:practica2/src/screens/dashboard.dart';
import 'package:practica2/src/screens/popular_screen.dart';
import 'package:practica2/src/screens/splash_screen.dart';
import 'package:practica2/src/screens/user_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/dashboard': (BuildContext context) => Dashboard(),
        '/popular': (BuildContext context) => PopularScreen(),
        '/detail': (BuildContext context) => DetailScreen(),
        '/profile': (BuildContext context) => ProfileScreen(),
        '/contact': (BuildContext context) => ContactScreen(),
        '/liked': (BuildContext context) => LikedScreen()
      },
      home: SplashScreenApp(),
    );
  }
}
