import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/theme.dart';

class LocationText extends StatelessWidget {
  final String location;
  const LocationText({Key key, @required this.location, @required this.isKH})
      : super(key: key);
  final bool isKH;
  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Icon(
          Icons.location_on,
          color: Palette.red,
          size: 16,
        ),
        Text(
          khNum(location, isKH),
          style: TextStyle(
            fontSize: isKH ? 12 : 13,
            fontFamily: isKH ? "Kantumruy" : "Open Sans",
            color: Palette.text.withOpacity(0.8),
          ),
        )
      ],
    );
  }
}
