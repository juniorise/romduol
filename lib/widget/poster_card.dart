import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/configs/scrollnotifer.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/screens/admin/a_why_tour.dart';
import 'package:romduol/screens/package/aboutpack.dart';

class PosterCard extends StatelessWidget {
  const PosterCard(
      {Key key, @required this.isKH, @required this.width, this.isEditable})
      : super(key: key);

  final bool isKH, isEditable;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScrollNotifier>(
      builder: (context, notifier, child) {
        return Container(
          width: width,
          height: 150,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Palette.sky,
            image: DecorationImage(
              image: AssetImage('assets/home/package_poster.png'),
              alignment: Alignment(0, notifier.offset.abs() * 0.002),
              fit: BoxFit.cover,
            ),
          ),
          child: child,
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Stack(
          children: [
            Positioned.fill(
              child: Container(color: Palette.sky.withOpacity(0.35)),
            ),
            FlatButton(
              splashColor: Palette.bg.withOpacity(0.1),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AboutTourPackage(isKH: isKH),
                ),
              ),
              padding: EdgeInsets.zero,
              child: Container(
                height: 150,
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  color: Palette.bgdark.withOpacity(0.2),
                ),
                child: Container(
                  padding: const EdgeInsets.only(left: 10.0, top: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Lang().of(key: 'ecotravelpackage', isKH: isKH),
                        style: TextStyle(
                          color: Colors.white.withOpacity(1),
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        Lang().of(key: 'posterpackageinfo', isKH: isKH),
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.white,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            isEditable
                ? Positioned(
                    left: 10,
                    bottom: 10,
                    child: ClipOval(
                      child: Container(
                        width: 40,
                        height: 40,
                        child: RaisedButton(
                          padding: EdgeInsets.zero,
                          child: Icon(
                            Icons.edit,
                            color: Palette.bgdark.withOpacity(1),
                          ),
                          highlightColor: Palette.bgdark.withOpacity(0.2),
                          color: Colors.white,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AdminWhyTourPackage(),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                : SizedBox(),
            Positioned(
              bottom: 5,
              right: 10,
              child: Container(
                width: 104.0 + 17,
                child: FlatButton.icon(
                  splashColor: Colors.transparent,
                  color: Palette.sky.withOpacity(0.25),
                  highlightColor: Palette.sky.withOpacity(0.35),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AboutTourPackage(isKH: isKH),
                      ),
                    );
                  },
                  icon: Icon(Icons.info, color: Colors.white, size: 16),
                  label: Text(
                    Lang().of(key: 'moreinfo', isKH: isKH),
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: isKH ? FontWeight.w400 : FontWeight.w300,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
