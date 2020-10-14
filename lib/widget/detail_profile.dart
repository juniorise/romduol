import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/google_map.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/star_rating.dart';

class DetailProfile extends StatelessWidget {
  const DetailProfile({
    Key key,
    @required this.width,
    this.pricefrom,
    this.pricetotal,
    @required this.title,
    @required this.location,
    @required this.onBookPressed,
    this.rate,
    this.ratetotal,
    this.maplocation,
    this.buslocation,
    this.isBookAble = false,
  }) : super(key: key);

  final GeoPoint maplocation, buslocation;
  final double width;
  final double pricefrom, pricetotal;
  final String title;
  final String location;
  final Function onBookPressed;
  final double rate;
  final int ratetotal;
  final bool isBookAble;

  @override
  Widget build(BuildContext context) {
    bool isShowPrice = pricefrom != null;

    double heightTOTAL = 20.0 + 20 + 14 + 16 + 15 + 48 + 17 - 10;
    return Container(
      height: rate != null ? heightTOTAL + 45 : heightTOTAL,
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
                  style: TextStyle(fontSize: 14),
                ),
              ),
              isShowPrice
                  ? Text(khNum("${khNum(pricefrom.toString())}\$"))
                  : SizedBox(),
            ],
          ),
          LocationText(location: location),
          SizedBox(height: 8.0),
          rate != null
              ? Row(
                  children: [
                    StarRating(rating: rate),
                    SizedBox(width: 5),
                    Text(
                      khNum(rate.toString()),
                      style: TextStyle(
                        color: Palette.text,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "(${khNum(ratetotal.toString())})",
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
                  onPressed: () {
                    print(maplocation.longitude + maplocation.latitude);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => GoogleMapTemplate(
                          maplocation: maplocation,
                          buslocation: buslocation,
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

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black87.withOpacity(0.2),
          blurRadius: 1.0,
          offset: Offset(0, 0),
        )
      ],
      color: Colors.white,
    );
  }
}
