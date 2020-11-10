import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/theme.dart';

class AboutTourPackage extends StatefulWidget {
  AboutTourPackage({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;
  @override
  _AboutTourPackageState createState() => _AboutTourPackageState();
}

List<String> image = [
  'assets/graphics/bicycle.png',
  'assets/graphics/family.png',
  'assets/graphics/piggy-bank.png',
  'assets/graphics/planet-earth.png',
];

class _AboutTourPackageState extends State<AboutTourPackage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.white),
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.close),
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/home/background.jpg",
              fit: BoxFit.cover,
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Palette.sky.withOpacity(0.8),
                  Palette.bgdark.withOpacity(0.6)
                ],
              ),
            ),
          ),
          Positioned.fill(
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('whytourpackage')
                    .orderBy('index')
                    .snapshots(),
                builder: (context, snapshot) {
                  List<UsefulPackParent> useful = List();
                  String lastdes = "", firstdes = "";
                  if (snapshot.hasData) {
                    snapshot.data.docs.forEach((element) {
                      if (element['index'] == 0) {
                        lastdes = element['lastdes'];
                        firstdes = element['firstdes'];
                      }
                      useful.add(UsefulPackParent(
                        title: element['title'],
                        path: element.reference.path,
                      ));
                    });
                  }
                  return ListView(
                    physics: BouncingScrollPhysics(),
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        child: Text(
                          firstdes,
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 20),
                      for (int i = 0; i < useful.length; i++)
                        Container(
                          margin: EdgeInsets.only(bottom: 20),
                          child: Stack(
                            alignment: Alignment.topCenter,
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(top: 30, bottom: 20),
                                width: width,
                                color: Colors.white.withOpacity(0.4),
                                child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection(
                                            useful[i].path + "/default_data")
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<WhyTourPackage> why = List();
                                      if (snapshot.hasData) {
                                        snapshot.data.docs.forEach((element) {
                                          why.add(
                                            WhyTourPackage(
                                              title: element['title'] ?? null,
                                              imageLocation:
                                                  element['imageLocation'] ??
                                                      null,
                                              des: element['des'],
                                              link: element['link'] ?? null,
                                            ),
                                          );
                                        });
                                        if (why.length > 0)
                                          return Wrap(
                                            children: [
                                              for (int i = 0;
                                                  i < why.length;
                                                  i++)
                                                usefulCard(
                                                  images: why[i].imageLocation,
                                                  width: width,
                                                  title: why[i].title,
                                                  des: why[i].des,
                                                ),
                                            ],
                                          );
                                        else
                                          return noData();
                                      }
                                      if (snapshot.hasError) return loading();
                                      return noData();
                                    }),
                              ),
                              Container(
                                height: 30,
                                width: 130,
                                alignment: Alignment.center,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: Palette.red,
                                ),
                                child: Text(
                                  useful[i].title,
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                        ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "ព័ត័មានពីការទូរទាត់ប្រាក់",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              lastdes,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                            SizedBox(height: 20),
                            Row(
                              children: [
                                FlatButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  onPressed: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                      ),
                                    )),
                                    child: Text(
                                      "រយៈពេលនៃការប្រើប្រាស់",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                                Text(
                                  " | ",
                                  style: TextStyle(color: Colors.white),
                                ),
                                FlatButton(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 5.0),
                                  minWidth: 40,
                                  onPressed: () {},
                                  child: Container(
                                    decoration: BoxDecoration(
                                        border: Border(
                                      bottom: BorderSide(
                                        color: Colors.white,
                                      ),
                                    )),
                                    child: Text(
                                      "ភាពឯកជន",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20),
                    ],
                  );
                }),
          )
        ],
      ),
    );
  }

  Container usefulCard({
    double width,
    String images,
    String title,
    String des,
  }) {
    return Container(
      height: null,
      //package container
      width: width,
      margin: EdgeInsets.only(bottom: 8, left: 10, right: 10),
      child: FlatButton(
        highlightColor: Palette.text.withOpacity(0.05),
        splashColor: Palette.bg,
        onPressed: () {},
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        padding: EdgeInsets.fromLTRB(0, 10, 8, 10),
        child: Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            Container(
              width: 110 - 20.0,
              height: 60,
              alignment: Alignment.center,
              child: NetworkImageLoader(
                imagelocation: images,
                onPressed: () {},
                width: 60,
                height: 60,
              ),
            ),
            SizedBox(width: 10),
            Container(
              width: width - 110.0 - 10 - 8,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.bgdark.withOpacity(0.8),
                    ),
                  ),
                  Text(
                    des,
                    style: TextStyle(
                      fontSize: 12,
                      color: Palette.text.withOpacity(0.6),
                    ),
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
