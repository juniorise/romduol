import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:romduol/data/data.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/home/homepage.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/database.dart';
import 'package:romduol/services/user_data.dart';
import 'package:romduol/widget/pageroutetransition.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authentication = AuthService();
  bool isLoading = true;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Timer timer;

  anonLogin() async {
    CustomUser user = await authentication.signInAnon();
    print(user.uid);
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

    getQuestion();

    timer = Timer.periodic(Duration(seconds: 2), (Timer t) => navigationPage());
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future<void> getQuestion() async {
    await FirebaseFirestore.instance
        .collection('questions')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        if (!question.contains(element['question']))
          question.add(element['question']);
      });
    });

    if (_auth.currentUser != null)
      setState(() => isLoading = false);
    else
      anonLogin();
  }

  void navigationPage() async {
    if (!isLoading) {
      Navigator.pushReplacement(
        context,
        PageRouteTransition(
          child: HomeStream(),
          duration: Duration(milliseconds: 500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

class HomeStream extends StatelessWidget {
  const HomeStream({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;
    return StreamProvider<List<PackageModel>>.value(
      value: Database().packagesData,
      builder: (_, snapshot) {
        return StreamBuilder<UserData>(
          stream: UserDatabase(
            uid: _auth.currentUser != null ? _auth.currentUser.uid : null,
          ).userData,
          builder: (context, usnapshot) {
            return const HomePage();
          },
        );
      },
    );
  }
}
