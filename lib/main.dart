import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/myapp.dart';

void main() {
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Kantumruy',
        backgroundColor: Palette.background,
        primaryColor: Palette.appbar,
        canvasColor: Palette.background,
        errorColor: Palette.sky,
        splashColor: Palette.white20.withOpacity(0),
        primaryTextTheme: TextTheme(
          headline6: TextStyle(
            color: Palette.sky,
            fontSize: 14,
          ),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Palette.sky),
        ),
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => MyApp(),
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
