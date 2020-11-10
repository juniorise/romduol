import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/widget/theme.dart';

class DatePickerCard extends StatelessWidget {
  const DatePickerCard({
    Key key,
    @required this.date,
    @required this.onPressed,
    this.isStart = false,
    @required this.isKH,
  }) : super(key: key);

  final bool isStart;
  final Date date;
  final Function onPressed;
  final bool isKH;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          children: [
            Text(
              isStart
                  ? isKH
                      ? 'ថ្ងៃកក់ឈ្មោះចូល'
                      : "From"
                  : isKH
                      ? 'ថ្ងៃបញ្ចប់'
                      : "End date",
              style: TextStyle(
                fontSize: 13,
                color: Palette.bgdark.withOpacity(0.8),
              ),
            ),
            SizedBox(height: 8.0),
            Container(
              width: 115,
              height: 140,
              decoration: buildBoxDecoration().copyWith(
                border: Border.all(color: Palette.sky),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10.0,
                    spreadRadius: 0,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: FlatButton(
                onPressed: onPressed,
                highlightColor: Palette.sky.withOpacity(0.1),
                splashColor: Colors.transparent,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      date.day,
                      style: TextStyle(
                        color: Palette.sky,
                        fontSize: 20,
                        height: 1.4,
                      ),
                    ),
                    Text(
                      date.month,
                      style: TextStyle(
                        color: Palette.sky,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      date.year,
                      style: TextStyle(
                        color: Palette.sky,
                        fontSize: 13,
                        height: 1.6,
                      ),
                    ),
                    SizedBox(height: 5.0),
                    Icon(
                      Icons.calendar_today,
                      color: Palette.sky,
                    ),
                  ],
                ),
              ),
            )
          ],
        )
      ],
    );
  }
}
