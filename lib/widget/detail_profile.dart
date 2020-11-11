import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/map/google_map.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/star_rating.dart';
import 'package:romduol/widget/theme.dart';

class DetailProfile extends StatelessWidget {
  const DetailProfile({
    Key key,
    @required this.width,
    this.pricefrom,
    this.pricetotal,
    @required this.title,
    @required this.location,
    @required this.onBookPressed,
    this.ratingaverage,
    this.ratetotal,
    this.maplocation,
    this.buslocation,
    this.isBookAble = false,
    @required this.isKH,
  }) : super(key: key);

  final GeoPoint maplocation, buslocation;
  final double width;
  final double pricefrom, pricetotal;
  final String title;
  final String location;
  final Function onBookPressed;
  final double ratingaverage;
  final int ratetotal;
  final bool isBookAble, isKH;

  @override
  Widget build(BuildContext context) {
    bool isShowPrice = pricefrom != null;
    double heightTOTAL = 20.0 + 20 + 14 + 16 + 15 + 48 + 17 - 10;
    double totalheight = ratingaverage != null ? heightTOTAL + 45 : heightTOTAL;
    return Container(
      height: totalheight,
      width: width,
      decoration: buildBoxDecoration(),
      padding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14,
                    color: Palette.bgdark.withOpacity(0.8),
                  ),
                ),
              ),
              isShowPrice
                  ? Text(khNum("${khNum(pricefrom.toString(), isKH)}\$", isKH))
                  : SizedBox(),
            ],
          ),
          LocationText(
            location: location,
            isKH: isKH,
          ),
          SizedBox(height: 8.0),
          ratingaverage != null
              ? Row(
                  children: [
                    StarRating(rating: ratingaverage.isNaN ? 0 : ratingaverage),
                    SizedBox(width: 5),
                    Text(
                      khNum(ratingaverage.isNaN ? 0.toString() : ratingaverage.toString(), isKH),
                      style: TextStyle(
                        color: Palette.text,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "(${khNum(ratetotal.toString(), isKH)})",
                      style: TextStyle(
                        color: Palette.bggrey,
                        fontSize: 12,
                      ),
                    )
                  ],
                )
              : SizedBox(),
          SizedBox(height: 7.0),
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
                  splashColor: Colors.transparent,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMapTemplate(
                          maplocation: maplocation ?? null,
                          buslocation: buslocation ?? null,
                          isKH: isKH,
                        ),
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
                          isKH ? "ទិសដៅ" : "Map",
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
              isBookAble
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
                        splashColor: Colors.transparent,
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
                                isKH ? "កក់ឥឡូវ" : "Book now",
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
