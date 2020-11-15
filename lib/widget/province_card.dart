import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/configs/scrollnotifer.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/widget/theme.dart';

class ProvinceCard extends StatelessWidget {
  const ProvinceCard({
    Key key,
    @required this.isKH,
    @required this.province,
    @required this.views,
    @required this.onPressed,
    @required this.imagelocation,
  }) : super(key: key);

  final bool isKH;
  final String province;
  final int views;
  final Function onPressed;
  final String imagelocation;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Consumer<ScrollNotifier>(builder: (context, notifier, child) {
      return Container(
        margin: EdgeInsets.zero,
        width: (width - 60) / 2,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Palette.text.withOpacity(0.2),
              blurRadius: 0,
              offset: Offset(-0.25, -0.25),
            )
          ],
          color: Colors.white,
        ),
        child: FlatButton(
          padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
          onPressed: onPressed,
          splashColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(1),
                child: Image.asset(
                  imagelocation,
                  height: 80,
                  fit: BoxFit.cover,
                  width: (width - 60) / 2,
                ),
              ),
              SizedBox(height: 5.0),
              Text(
                province,
                style: TextStyle(
                  fontSize: isKH ? 14 : 15,
                  color: Palette.sky,
                ),
              ),
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      style: TextStyle(
                        height: 1.6,
                        fontSize: 13,
                        fontFamily: 'Kantumruy',
                        color: Palette.bgdark.withOpacity(0.8),
                      ),
                      children: [
                        TextSpan(
                          text: "${khNum(views.toString(), isKH)}",
                        ),
                        TextSpan(
                          text: " ",
                          style: TextStyle(fontSize: isKH ? 3 : 10),
                        ),
                        TextSpan(
                          text: Lang().of(key: 'views', isKH: isKH),
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w300,
                            color: Palette.bgdark.withOpacity(1),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.remove_red_eye,
                    size: 12,
                    color: Palette.text.withOpacity(0.0),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }
}
