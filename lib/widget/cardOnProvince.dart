import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/detail_template.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/star_rating.dart';

class CardOnProvince extends StatelessWidget {
  final String title, location, thumbnail, opentime, id;
  final int ratetotal;
  final double rating, pricefrom, pricetotal;
  final GeoPoint maplocation;

  const CardOnProvince({
    Key key,
    @required this.title,
    @required this.location,
    @required this.thumbnail,
    this.opentime,
    @required this.id,
    this.ratetotal,
    this.rating,
    this.pricefrom,
    this.pricetotal,
    this.maplocation,
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
            color: Colors.black87.withOpacity(0.2),
            blurRadius: 10.0,
            spreadRadius: -20,
            offset: Offset(0, 25),
          )
        ],
      ),
      child: Column(
        children: [
          Stack(
            children: [
              NetworkImageLoader(
                onPressed: () {},
                width: width - 15 - 15,
                height: 90,
                imagelocation: thumbnail,
              ),
              pricefrom != null
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
                          "ចាប់ពី​ ${pricefrom.toInt()}\$ - ${pricetotal.toInt()}\$",
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
                      rating != null
                          ? Row(
                              children: [
                                StarRating(rating: rating),
                                SizedBox(width: 5),
                                Text(
                                  rating.toString(),
                                  style: TextStyle(
                                    color: Palette.text,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "($ratetotal)",
                                  style: TextStyle(
                                    color: Palette.bggrey,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          : SizedBox(),
                      Container(
                        width: pricefrom == null ? 104 : 104.0 + 17,
                        child: FlatButton.icon(
                          color: Palette.sky,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => DetailTemplate(),
                              ),
                            );
                          },
                          icon: Icon(Icons.info, color: Colors.white, size: 16),
                          label: Text(
                            pricefrom == null ? "អានបន្ថែម" : "ព័ត៏មានបន្ថែម",
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
