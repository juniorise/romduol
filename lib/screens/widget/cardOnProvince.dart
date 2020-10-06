import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/widget/location.dart';
import 'package:romduol/screens/widget/star_rating.dart';

class CardOnProvince extends StatelessWidget {
  final String title, location, imageLocation, price, id;
  final double ratestar;

  const CardOnProvince({
    Key key,
    @required this.title,
    @required this.location,
    @required this.imageLocation,
    @required this.id,
    this.price,
    this.ratestar,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double width = size.width;
    // double height = size.height;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black87.withOpacity(0.5),
            blurRadius: 10.0,
            spreadRadius: -20,
            offset: Offset(0, 15),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              Image.asset(
                imageLocation,
                width: width - 15 - 15,
                height: 90,
                fit: BoxFit.cover,
              ),
              price != null
                  ? Positioned(
                      top: 10,
                      left: 0,
                      child: Container(
                        height: 36,
                        alignment: Alignment.center,
                        color: Colors.white.withOpacity(0.8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        child: Text(
                          "ចាប់ពី​ $price",
                          style: TextStyle(fontSize: 12, color: Palette.text),
                        ),
                      ),
                    )
                  : SizedBox(),
            ],
          ),
          Container(
            width: width - 15 - 15,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                LocationText(location: location),
                Container(
                  height: 32,
                  alignment: Alignment.bottomRight,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ratestar != null
                          ? Row(
                              children: [
                                StarRating(rating: ratestar),
                                SizedBox(width: 5),
                                Text(
                                  "4",
                                  style: TextStyle(
                                    color: Palette.text,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "(50)",
                                  style: TextStyle(
                                    color: Palette.bggrey,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          : SizedBox(),
                      Container(
                        width: price == null ? 104 : 104.0 + 17,
                        child: FlatButton.icon(
                          color: Palette.sky,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {},
                          icon: Icon(Icons.info, color: Colors.white, size: 16),
                          label: Text(
                            price == null ? "អានបន្ថែម" : "ព័ត៏មានបន្ថែម",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
