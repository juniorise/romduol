import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/localization/localization.dart';
import 'package:romduol/screens/myapp.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MaterialApp(
      theme: ThemeData(
        fontFamily: 'Kantumruy',
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
      localizationsDelegates: [
        AppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', ''), // English, no country code
        const Locale('kh', ''),
      ],
      onGenerateTitle: (BuildContext context) =>
          AppLocalization.of(context).title,
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
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
