import 'package:flutter/material.dart';
import 'package:romduol/widget/theme.dart';

class SettingScreen extends StatefulWidget {
  SettingScreen({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "ការកំណត់", isKH: widget.isKH),
      body: ListView(
        children: [],
      ),
    );
  }
}
