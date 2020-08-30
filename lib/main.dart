import 'package:flutter/material.dart';
import 'screens/screens.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Kantumruy',
        backgroundColor: Palette.background,
        primaryColor: Palette.appbar,
        canvasColor: Palette.background,
        errorColor: Palette.red,
        splashColor: Palette.white20,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => Home(),
        '/Splash': (context) => SplashScreen(),
      },
    ),
  );
}

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
