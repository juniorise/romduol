import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/homepage.dart';
import 'package:romduol/services/database.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
        
    return StreamProvider<List<PackageModel>>.value(
      value: Database().packagesData,
      builder: (context, snapshot) {
        return HomePage();
      },
    );
  }
}
