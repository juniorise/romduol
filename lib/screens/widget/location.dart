import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

class LocationText extends StatelessWidget {
  final String location;
  const LocationText({Key key, @required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        Icon(
          Icons.location_on,
          color: Palette.red,
          size: 16,
        ),
        Text(
          location,
          style: TextStyle(
            fontSize: 12,
            color: Palette.text.withOpacity(0.8),
          ),
        )
      ],
    );
  }
}
