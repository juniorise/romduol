import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/pagenotifier.dart';
import 'package:romduol/screens/homepage.dart';
import 'dart:math' as math;

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController =
        PageController(initialPage: 1, viewportFraction: 1.0, keepPage: true);
  }

  bool isOpen = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return ChangeNotifierProvider(
      create: (_) => PageViewNotifier(_pageController),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/home/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: Stack(
          children: [
            PageView(
              controller: _pageController,
              children: [
                Container(
                  color: Colors.transparent,
                  width: width,
                ),
                Container(
                  color: Colors.transparent,
                )
              ],
            ),
            Consumer<PageViewNotifier>(
              builder: (context, notifier, child) {
                return Transform.translate(
                  offset: Offset(
                      math.min(width * 0.7 - 2, width - notifier.offset - 2),
                      0),
                  child: child,
                );
              },
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            HomePage(pageController: _pageController, isOpen: isOpen),
          ],
        ),
      ),
    );
  }
}
