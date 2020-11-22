import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/province/detail_template.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/scaleDown_onTab.dart';
import 'package:romduol/widget/star_rating.dart';
import 'package:romduol/widget/theme.dart';

class CardOnProvince extends StatefulWidget {
  final CardModel data;
  final bool isKH;
  final Function onPop;
  final int index;
  const CardOnProvince(
      {Key key,
      @required this.data,
      @required this.isKH,
      this.onPop,
      this.index})
      : super(key: key);

  @override
  _CardOnProvinceState createState() => _CardOnProvinceState();
}

class _CardOnProvinceState extends State<CardOnProvince> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    // double height = size.height;
    Function onTab = () async {
      bool isEdited = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailTemplate(
            index: widget.index,
            data: widget.data,
            isKH: widget.isKH,
          ),
        ),
      );
      if (isEdited) widget.onPop();
    };
    return ScaleDownOnTab(
      onTab: onTab,
      child: Container(
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
                  tag: widget.data.id != null
                      ? widget.data.id + widget.index.toString()
                      : widget.data.thumbnail + widget.index.toString(),
                  child: NetworkImageLoader(
                    onPressed: () {},
                    width: width - 15 - 15,
                    height: 90,
                    imagelocation: widget.data.thumbnail,
                  ),
                ),
                widget.data.pricefrom.isNaN &&
                        widget.data.pricefrom > 0 &&
                        widget.data.pricetotal > 0
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
                              (widget.isKH ? "ចាប់ពី​ " : "") +
                                  "${widget.data.pricefrom}\$ - ${widget.data.pricetotal}\$",
                              widget.isKH,
                            ),
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
                    widget.data.title,
                    style: TextStyle(color: Palette.bgdark.withOpacity(0.8)),
                  ),
                  LocationText(
                    location: widget.data.location,
                    isKH: widget.isKH,
                  ),
                  Container(
                    height: 32,
                    alignment: Alignment.bottomRight,
                    width: width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.data.ratingaverage != null
                            ? Row(
                                children: [
                                  StarRating(
                                    rating: widget.data.ratingaverage.isNaN
                                        ? 0
                                        : widget.data.ratingaverage,
                                  ),
                                  SizedBox(width: 5),
                                  Text(
                                    khNum(
                                        !widget.data.ratingaverage.isNaN
                                            ? widget.data.ratingaverage
                                                .toString()
                                            : 0.toString(),
                                        widget.isKH),
                                    style: TextStyle(
                                      color: Palette.text,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                    "(" +
                                        khNum(widget.data.ratetotal.toString(),
                                            widget.isKH) +
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
                          child: FlatButton.icon(
                            splashColor: Colors.transparent,
                            color: Palette.sky,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18)),
                            onPressed: onTab,
                            icon:
                                Icon(Icons.info, color: Colors.white, size: 16),
                            label: Text(
                              !(widget.data.pricefrom != null &&
                                      widget.data.pricefrom > 0 &&
                                      widget.data.pricetotal > 0)
                                  ? widget.isKH
                                      ? "អានបន្ថែម"
                                      : "Read more"
                                  : widget.isKH
                                      ? "ព័ត៏មានបន្ថែម"
                                      : "More info",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontFamily: 'Kantumruy',
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
      ),
    );
  }
}
