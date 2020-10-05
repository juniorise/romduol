import 'package:flutter/material.dart';
import 'package:romduol/screens/homepage.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with SingleTickerProviderStateMixin {
  Animation<double> _animation;
  AnimationController _animationController;
  Duration duration = Duration(milliseconds: 400);
  
  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(vsync: this, duration: duration);
    CurvedAnimation _curveAnimtaion = CurvedAnimation(
        curve: Curves.easeInOutQuart, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 200).animate(_curveAnimtaion)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {});
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage("assets/home/background.jpg"), fit: BoxFit.cover),
      ),
      child: GestureDetector(
        onHorizontalDragDown: (detail){
          // print(detail);

        },
        onHorizontalDragUpdate: (detail){
          print(detail);
        },
        onHorizontalDragEnd: (detail){
          // print(detail);
        },
        child: Stack(
          children: [
            Transform.translate(
              offset: Offset(_animation.value, 0),
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(_animation.value, 0),
              child: HomePage(animationController: _animationController),
            ),
          ],
        ),
      ),
    );
  }
}
