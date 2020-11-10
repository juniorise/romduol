import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/home/homepage.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/database.dart';
import 'package:romduol/widget/pageroutetransition.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authentication = AuthService();
  bool isLoading = true;
  Timer timer;

  anonLogin() async {
    await authentication.signInAnon();
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);

    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => navigationPage());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void navigationPage() {
    if (!isLoading) {
      Navigator.pushReplacement(
        context,
        PageRouteTransition(
          child: StreamProvider<List<PackageModel>>.value(
            value: Database().packagesData,
            builder: (_, snapshot) => HomePage(),
          ),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    if (user != null) {
      setState(() {
        isLoading = false;
      });
    } else {
      anonLogin();
    }

    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
