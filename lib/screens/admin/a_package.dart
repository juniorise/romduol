import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/admin/add_package.dart';
import 'package:romduol/widget/pageroutetransition.dart';
import 'package:romduol/widget/theme.dart';
import 'a_province.dart';

class AdminPackage extends StatefulWidget {
  AdminPackage({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;

  @override
  _AdminPackageState createState() => _AdminPackageState();
}

class _AdminPackageState extends State<AdminPackage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar:
          buildAppBar(title: "Package draft", isKH: widget.isKH, isBlue: true),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
              context,
              PageRouteTransition(
                  child: AdminProvince(
                isKH: widget.isKH,
              )));
        },
        child: Icon(Icons.switch_right),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            width: width,
            height: 48,
            decoration: buildBoxDecoration(),
            child: FlatButton.icon(
              highlightColor: Palette.sky.withOpacity(0.3),
              height: 48,
              icon: Icon(
                Icons.add_rounded,
                color: Palette.sky,
              ),
              label: Text(
                "Add new data",
                style: TextStyle(
                  color: Palette.sky,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddPackage(
                      isKH: widget.isKH,
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
