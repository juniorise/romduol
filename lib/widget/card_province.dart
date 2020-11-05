import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/province/detail_template.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/star_rating.dart';
import 'package:romduol/widget/theme.dart';

class CardOnProvince extends StatelessWidget {
  final CardModel data;
  final bool isKH;
  const CardOnProvince({Key key, @required this.data, @required this.isKH})
      : super(key: key);

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
            color: Colors.black.withOpacity(0.05),
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
              Hero(
                tag: "thumnail" + data.thumbnail,
                child: NetworkImageLoader(
                  onPressed: () {},
                  width: width - 15 - 15,
                  height: 90,
                  imagelocation: data.thumbnail,
                ),
              ),
              data.pricefrom != null
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
                          khNum(
                              (isKH
                                  ? "ចាប់ពី​ "
                                  : "")
                                       + "${data.pricefrom}\$ - ${data.pricetotal}\$",
                              isKH),
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
                Text(
                  data.title,
                  style: TextStyle(color: Palette.bgdark.withOpacity(0.8)),
                ),
                LocationText(
                  location: data.location,
                  isKH: isKH,
                ),
                Container(
                  height: 32,
                  alignment: Alignment.bottomRight,
                  width: width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      data.rating != null
                          ? Row(
                              children: [
                                StarRating(rating: data.rating),
                                SizedBox(width: 5),
                                Text(
                                  khNum(data.rating.toString(), isKH),
                                  style: TextStyle(
                                    color: Palette.text,
                                    fontSize: 14,
                                  ),
                                ),
                                Text(
                                  "(" +
                                      khNum(data.ratetotal.toString(), isKH) +
                                      ")",
                                  style: TextStyle(
                                    color: Palette.bggrey,
                                    fontSize: 12,
                                  ),
                                )
                              ],
                            )
                          : SizedBox(),
                      Container(
                        width: data.pricefrom == null
                            ? isKH
                                ? 104
                                : 104.0 + 10
                            : 104.0 + 17,
                        child: FlatButton.icon(
                          splashColor: Colors.white.withOpacity(0.2),
                          color: Palette.sky,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18)),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailTemplate(data: data, isKH: isKH),
                              ),
                            );
                          },
                          icon: Icon(Icons.info, color: Colors.white, size: 16),
                          label: Text(
                            data.pricefrom == null
                                ? isKH
                                    ? "អានបន្ថែម"
                                    : "Read more"
                                : isKH
                                    ? "ព័ត៏មានបន្ថែម"
                                    : "More info",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontFamily: isKH ? 'Kantumruy' : 'Open Sans',
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
