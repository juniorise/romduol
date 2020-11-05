import 'package:flutter/material.dart';
import 'package:romduol/widget/theme.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;

  @override
  _NotificationScreenState createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: "ការជូនដំណឹង", isKH: widget.isKH),
      body: ListView(
        children: [],
      ),
    );
  }
}
