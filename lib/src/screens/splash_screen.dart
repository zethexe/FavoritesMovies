import 'package:flutter/material.dart';
import 'package:practica2/src/screens/login.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenApp extends StatefulWidget {
  SplashScreenApp({Key key}) : super(key: key);

  @override
  _SplashScreenAppState createState() => _SplashScreenAppState();
}

class _SplashScreenAppState extends State<SplashScreenApp> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 1,
      navigateAfterSeconds: Login(),
      title: Text("Bienvenidos"),
      image: Image.asset('assets/palomitas.png', width: 400, height: 250),
      gradientBackground: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.blue, Colors.blueGrey]),
      loaderColor: Colors.red,
      loadingText: Text("Comenzando aplicacion..."),
    );
  }
}
