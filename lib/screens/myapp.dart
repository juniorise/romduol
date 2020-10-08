import 'package:flutter/material.dart';
import 'package:flutter_inner_drawer/inner_drawer.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/homepage.dart';
import 'package:romduol/screens/widget/drawerListTile.dart';
import 'package:romduol/services/database.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final GlobalKey<InnerDrawerState> _innerDrawerKey =
      GlobalKey<InnerDrawerState>();

  @override
  Widget build(BuildContext context) {
    return InnerDrawer(
      boxShadow: [BoxShadow(offset: Offset(0, 0))],
      key: _innerDrawerKey,
      onTapClose: true,
      backgroundDecoration: BoxDecoration(
        border: Border.all(width: 0),
        color: Palette.bg,
      ),
      leftChild: HiddenDrawer(),
      scaffold: StreamProvider<List<PackageModel>>.value(
        value: Database().packagesData,
        builder: (context, snapshot) {
          return HomePage(
            onTab: () => _innerDrawerKey.currentState.toggle(),
          );
        },
      ),
    );
  }
}

class HiddenDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Palette.sky,
              height: 80,
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Container(
                    width: 60,
                    height: 60,
                    child: Image.asset("assets/home/profile.png"),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 3),
                      borderRadius: BorderRadius.circular(60 / 2),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Sothea",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Kantumruy",
                          ),
                        ),
                        Text(
                          "test@testing.com",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontFamily: "Kantumruy",
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
            ),
            SizedBox(height: 2.0),
            DrawerListTile(
                icon: Icons.settings, title: "Setting", onPressed: () {}),
            DrawerListTile(
                icon: Icons.call, title: "Contact us", onPressed: () {}),
            DrawerListTile(
                icon: Icons.logout, title: "Signout", onPressed: () {}),
            Expanded(
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(10),
                child: Text(
                  "v1.2",
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: "Kantumruy",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
