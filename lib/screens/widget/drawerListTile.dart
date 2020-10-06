import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key key,
    this.title,
    this.onPressed,
    this.icon,
  }) : super(key: key);

  final String title;
  final Function onPressed;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.centerLeft,
      child: FlatButton(
        height: 50,
        onPressed: onPressed,
        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        child: Row(
          children: [
            Icon(
              icon,
              color: Palette.sky,
            ),
            SizedBox(width: 8),
            Text(
              title,
              textAlign: TextAlign.start,
              style: TextStyle(color: Palette.sky, fontFamily: "Kantumruy", fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
