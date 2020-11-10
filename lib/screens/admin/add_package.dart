import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/theme.dart';

class AddPackage extends StatefulWidget {
  AddPackage({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;

  @override
  _AddPackageState createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(title: "Add new package", isKH: widget.isKH),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            height: 48,
            width: width,
            decoration: buildBoxDecoration(),
            child: Center(
              child: Text(
                'Developing',
                style: TextStyle(color: Palette.sky),
              ),
            ),
          )
        ],
      ),
    );
  }
}
