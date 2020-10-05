import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/pagenotifier.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/place.dart';
import 'package:romduol/screens/widget/animatedtabbar.dart';

class Province extends StatefulWidget {
  Province({Key key}) : super(key: key);

  @override
  _ProvinceState createState() => _ProvinceState();
}

class _ProvinceState extends State<Province> {
  PageController _pageController;
  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: 0,
      keepPage: true,
      viewportFraction: 1.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return ChangeNotifierProvider(
      create: (e) => PageViewNotifier(_pageController),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          title: Text(
            "រុករក",
            style: TextStyle(fontSize: 16, color: Palette.sky),
            textAlign: TextAlign.start,
          ),
          bottom: PreferredSize(
            child: AnimatedTabBar(
              pageController: _pageController,
            ),
            preferredSize: Size.fromHeight(60),
          ),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            Places(),
            Container(
              color: Palette.bg,
              width: width,
              height: height,
            ),
            Container(
              color: Colors.green,
              width: width,
              height: height,
            ),
            Container(
              color: Palette.bg,
              width: width,
              height: height,
            ),
          ],
        ),
      ),
    );
  }
}
