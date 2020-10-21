import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/myapp.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:romduol/widget/pageroutetransition.dart';
import './lang/lang.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  bool isKH = true;
  isKH = await Lang().isKH() ?? true;
  if (isKH == null) isKH = true;

  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: isKH ? 'Kantumruy' : 'Open Sans',
        backgroundColor: Palette.background,
        primaryColor: Palette.appbar,
        canvasColor: Palette.background,
        errorColor: Palette.sky,
        primaryTextTheme: TextTheme(
          headline6: TextStyle(color: Palette.sky, fontSize: 14),
        ),
        appBarTheme: AppBarTheme(
          centerTitle: false,
          elevation: 0.0,
          iconTheme: IconThemeData(color: Palette.sky),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: MyApp(),
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
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var _duration = Duration(seconds: 1);
    Timer(_duration, navigationPage);
    super.initState();
  }

  void navigationPage() {
    Navigator.pushReplacement(
      context,
      PageRouteTransition(
        child: MyApp(),
        duration: Duration(milliseconds: 1000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
