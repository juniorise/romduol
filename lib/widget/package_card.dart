import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/package/package_detail.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/theme.dart';


class PackageCard extends StatelessWidget {
  const PackageCard({
    Key key,
    @required AnimationController animationController,
    @required this.isKH,
    @required this.width,
    @required this.package,
    @required this.onErrorPressed,
    @required this.index,
  })  : _animationController = animationController,
        super(key: key);

  final AnimationController _animationController;
  final bool isKH;
  final double width;
  final PackageModel package;
  final Function onErrorPressed;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: null,
      //package container
      width: width,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Palette.bgdark.withOpacity(0.1),
            width: 0.5,
          ),
        ),
      ),
      child: FlatButton(
        splashColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
        onPressed: () async {
          _animationController.forward();
          await Navigator.push(
            context,
            PageTransition(
              child: PackageDetail(
                package: package,
                isKH: isKH,
                index: index,
              ),
              curve: Curves.ease,
              duration: Duration(milliseconds: 150),
              type: PageTransitionType.fade,
            ),
          );
          _animationController.reverse();
        },
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Stack(
              //left side - image + booked/total people join
              children: [
                Container(
                  width: 110,
                  height: 60,
                  alignment: Alignment.center,
                  child: Hero(
                    tag: package.id != null
                        ? package.id + index.toString()
                        : package.thumbnail + index.toString(),
                    child: NetworkImageLoader(
                      onPressed: onErrorPressed,
                      imagelocation: package.thumbnail,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: 110,
                    color: Palette.bgdark.withOpacity(0.25),
                    padding: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: TextStyle(
                          color: Colors.white.withOpacity(1),
                          fontFamily: 'Kantumruy',
                          fontWeight: FontWeight.w300,
                          fontSize: 11,
                        ),
                        children: [
                          TextSpan(
                            text:
                                "${khNum(package.bookedspace.toString(), isKH)}",
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text:
                                "/${khNum(package.totalspace.toString(), isKH)} ",
                          ),
                          TextSpan(text: isKH ? 'នាក់' : "Joined")
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(width: 10),
            Container(
              //right side
              width: width - 110 - 40 - 10,
              //width = width - leftside(110) - padding(20) * 2 - sizebox(10)
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    //first row - title + price
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          package.title,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: isKH ? 14 : 15,
                            color: Palette.bgdark.withOpacity(0.8),
                          ),
                        ),
                      ),
                      Text(
                        "${khNum(package.price.toString(), isKH)}\$",
                        style: TextStyle(
                          fontSize: 14,
                          color: Palette.sky,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5.0),

                  //second row - location + date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocationText(
                        location: package.location,
                        isKH: isKH,
                      ),
                      SizedBox(width: 5),
                      Flexible(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                            vertical: 0,
                            horizontal: 5,
                          ),
                          color: Palette.text.withOpacity(0.1),
                          child: Text(
                            khNum(package.date, isKH),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 12,
                              color: Palette.text,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
