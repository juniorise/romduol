import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/widget/location.dart';

class Places extends StatefulWidget {
  Places({Key key}) : super(key: key);

  @override
  _PlacesState createState() => _PlacesState();
}

class _PlacesState extends State<Places> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      color: Palette.bg,
      width: width,
      height: height,
      child: ListView(
        children: [
          PlaceCard(width: width),
          PlaceCard(width: width),
          PlaceCard(width: width),
          PlaceCard(width: width),
        ],
      ),
    );
  }
}

class PlaceCard extends StatelessWidget {
  const PlaceCard({
    Key key,
    @required this.width,
  }) : super(key: key);

  final double width;

  @override
  Widget build(BuildContext context) {
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
          Image.asset(
            "assets/provinces/kep.png",
            width: width - 15 - 15,
            height: 90,
            fit: BoxFit.cover,
          ),
          Container(
            width: width - 15 - 15,
            color: Colors.white,
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("រង្វង់មូលធុរេន"),
                LocationText(location: "ទីតាំងស្ថិតនៅក្នុងខេត្តកំពត"),
                Container(
                  height: 36,
                  alignment: Alignment.bottomRight,
                  width: width,
                  child: Container(
                    width: 121,
                    child: FlatButton.icon(
                      color: Palette.sky,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18)),
                      onPressed: () {},
                      icon: Icon(Icons.info, color: Colors.white, size: 16),
                      label: Text(
                        "ព័ត៍មានបន្ថែម",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ),
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
