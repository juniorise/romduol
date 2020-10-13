import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/google_map.dart';
import 'package:romduol/widget/location.dart';

class DetaiProfile extends StatelessWidget {
  const DetaiProfile({
    Key key,
    @required this.width,
    this.price, @required this.title, @required this.location, @required this.onBookPressed,
  }) : super(key: key);

  final double width;
  final int price;
  final String title;
  final String location;
  final Function onBookPressed;

  @override
  Widget build(BuildContext context) {
    bool isHasPrice = price != null;
    return Container(
      height: 20.0 + 20 + 14 + 16 + 15 + 48 + 17,
      width: width,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.2),
            blurRadius: 10.0,
            spreadRadius: -20,
            offset: Offset(0, 25),
          )
        ],
        color: Colors.white,
      ),
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              isHasPrice ? Text('$price\$') : SizedBox(),
            ],
          ),
          LocationText(location: location),
          SizedBox(height: 15.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                height: 48,
                alignment: Alignment.center,
                width: width * .5 - 20 - 5,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Palette.sky,
                  ),
                ),
                child: FlatButton(
                  height: 48,
                  highlightColor: Palette.sky.withOpacity(0.2),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMapTemplate(),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(width: 5.0),
                      Image.asset(
                        "assets/graphics/google_map_icon.png",
                        height: 28,
                        fit: BoxFit.cover,
                      ),
                      Expanded(
                        child: Text(
                          "ទិសដៅ",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Palette.sky,
                            fontSize: 12,
                          ),
                        ),
                      ),
                      SizedBox(width: 5.0),
                    ],
                  ),
                ),
              ),
              isHasPrice
                  ? Container(
                      height: 48,
                      alignment: Alignment.center,
                      width: width * .5 - 20 - 5,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          color: Palette.yellow,
                        ),
                        color: Palette.yellow,
                      ),
                      child: FlatButton(
                        height: 50,
                        onPressed: onBookPressed,
                        highlightColor: Colors.amber.withOpacity(0.5),
                        child: Row(
                          children: [
                            SizedBox(width: 5.0),
                            Icon(
                              Icons.collections_bookmark,
                              size: 24,
                              color: Colors.white,
                            ),
                            Expanded(
                              child: Text(
                                "កក់ឥឡូវ",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                            SizedBox(width: 5.0),
                          ],
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          )
        ],
      ),
    );
  }
}
