import 'dart:math';
import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/data/data.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/package_detail.dart';
import 'package:romduol/screens/myapp.dart';
import 'package:romduol/screens/province.dart';
import 'package:romduol/widget/drawer.dart';
import 'package:romduol/widget/location.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/pageroutetransition.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  final Function onTab;
  const HomePage({Key key, this.onTab}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final List<PackageModel> packages =
        Provider.of<List<PackageModel>>(context) ?? [];
    var scaffoldKey = GlobalKey<ScaffoldState>();
    // Backup().autoBackupProvince();
    // Backup().autoBackupPackages();

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: scaffoldKey,
      appBar: buildAppBar(context, "រំដួល"),
      drawer: HomeDrawer(),
      body: GestureDetector(
        onHorizontalDragEnd: (e) {
          if (e.velocity.pixelsPerSecond.direction > 0 &&
              e.velocity.pixelsPerSecond.dx > 0) {
            scaffoldKey.currentState.openDrawer();
          }
        },
        child: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              top: -80,
              child: Column(
                children: [
                  Container(
                    height: height * 0.78,
                    width: width,
                    child: Image.asset(
                      "assets/home/background.jpg",
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: height * 0.22 + 80,
                    width: width,
                    child: Image.asset(
                      "assets/home/background.jpg",
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Container(
                color: Palette.sky.withOpacity(0.5),
              ),
            ),
            RefreshIndicator(
              onRefresh: () => Navigator.pushReplacement(
                context,
                PageRouteTransition(
                  child: MyApp(),
                  duration: Duration(milliseconds: 500),
                ),
              ),
              child: ListView(
                children: [
                  //HELLO TITLE
                  StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('questions')
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        snapshot.data.docs.forEach(
                          (element) {
                            if (!question.contains(element['question']))
                              question.add(element['question']);
                          },
                        );
                      return hello(width, question);
                    },
                  ),

                  //PROVINCES
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    color: Colors.white,
                    width: width,
                    child: Column(
                      children: [
                        sectionTitle("សូមជ្រើសរើសខេត្តណាមួយនៃតំបន់ឆ្នេរ"),
                        Stack(
                          children: [
                            Container(
                              height: width > 360 ? 155 : 290,
                              child: LiveGrid.options(
                                physics: NeverScrollableScrollPhysics(),
                                options: options,
                                itemBuilder: (context, index, animation) {
                                  ProvinceModel data = provinces[index];
                                  return FadeTransition(
                                    opacity: Tween<double>(
                                      begin: 0,
                                      end: 1,
                                    ).animate(animation),
                                    child: buildProvinceCard(
                                      context: context,
                                      province: data.province,
                                      views: data.views,
                                      imagelocation: data.imagelocation,
                                      onPressed: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Province(
                                            province: data.province,
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                itemCount: 4,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: width > 360 * 2 ? 4 : 2,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 8 / 7,
                                ),
                              ),
                            ),
                            width < 360 * 2
                                ? Positioned.fill(
                                    top: -1.5,
                                    right: 0.2,
                                    child: IgnorePointer(
                                      child: Container(
                                        child: Center(
                                          child: SvgPicture.asset(
                                            'assets/graphics/provincedivider.svg',
                                            width: 100,
                                            height: 100,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                : SizedBox(),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0), //ECO TRAVEL PACKAGE
                  Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(15),
                    width: width,
                    child: Column(
                      children: [
                        posterCard(width),
                        SizedBox(height: 5),
                        sectionTitle("ចូលរួមជាមួយពួកយើង"),
                        Wrap(
                          children: [
                            packages.length != null
                                ? LiveList.options(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    options: options,
                                    itemCount: packages.length,
                                    itemBuilder: (context, i, animation) {
                                      return FadeTransition(
                                        opacity: Tween<double>(
                                          begin: 0,
                                          end: 1,
                                        ).animate(animation),
                                        child: packageCard(
                                          width: width,
                                          package: packages[i],
                                          onErrorPressed: () =>
                                              Navigator.pushReplacement(
                                            context,
                                            PageRouteTransition(
                                              child: MyApp(),
                                              duration:
                                                  Duration(milliseconds: 500),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  )
                                : Center(
                                    heightFactor: 2,
                                    child: CircularProgressIndicator(),
                                  ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  final options = LiveOptions(
    showItemInterval: Duration(milliseconds: 100),
    showItemDuration: Duration(milliseconds: 500),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  Column packageCard({
    double width,
    PackageModel package,
    Function onErrorPressed,
  }) {
    return Column(
      children: [
        Container(
          height: null,
          //package container
          width: width,
          child: FlatButton(
            highlightColor: Palette.text.withOpacity(0.05),
            splashColor: Palette.bg,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PackageDetail(package: package),
                ),
              );
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
                        tag: "thumnail" + package.thumbnail,
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
                        color: Palette.sky.withOpacity(0.7),
                        padding: EdgeInsets.zero,
                        alignment: Alignment.center,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                                color: Colors.white.withOpacity(1),
                                fontFamily: "Kantumruy",
                                fontWeight: FontWeight.w300),
                            children: [
                              TextSpan(
                                text:
                                    "${khNum(package.bookedspace.toString())}",
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "/${khNum(package.totalspace.toString())} នាក់",
                                style: TextStyle(fontSize: 11),
                              ),
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
                              style:
                                  TextStyle(fontSize: 14, color: Palette.text),
                            ),
                          ),
                          Text(
                            "${khNum(package.price.toInt().toString())}\$",
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
                          LocationText(location: package.location),
                          SizedBox(width: 5),
                          Flexible(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                vertical: 0,
                                horizontal: 5,
                              ),
                              color: Palette.text.withOpacity(0.1),
                              child: Text(
                                khNum(package.date),
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 12, color: Palette.text),
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
        ),
        Divider()
      ],
    );
  }

  Container posterCard(double width) {
    return Container(
      width: width,
      height: 150,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/home/package_poster.png'),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(5),
      ),
      child: FlatButton(
        splashColor: Palette.bg.withOpacity(0.1),
        onPressed: () {},
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Container(
          height: 150,
          width: width,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x00000000),
                Color(0x99000000),
              ],
            ),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.only(left: 10.0, top: 10),
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    style: TextStyle(
                      color: Colors.white.withOpacity(1),
                      fontFamily: "Kantumruy",
                      fontSize: 20,
                    ),
                    children: [
                      TextSpan(
                        text: "អេកូ-កញ្ចប់",
                      ),
                      TextSpan(
                        text: "ដំណើរកំសាន្ត",
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: width,
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.only(bottom: 8),
                color: Palette.sky70,
                child: Text(
                  "ដំណើរកំសាន្តប្រកបដោយចីរភាព សន្សំសច្ចៃ និង មានសុវត្តិភាព",
                  style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white,
                      fontWeight: FontWeight.w300),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container sectionTitle(String title) {
    return Container(
      padding: const EdgeInsets.all(5),
      width: MediaQuery.of(context).size.width,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 14, color: Palette.text),
      ),
    );
  }

  Container buildProvinceCard({
    String province,
    int views,
    Function onPressed,
    String imagelocation,
    BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.zero,
      width: (width - 60) / 2,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Palette.text.withOpacity(0.1),
            blurRadius: 0,
            offset: Offset(-0.25, -0.25),
          )
        ],
        color: Colors.white,
      ),
      child: FlatButton(
        padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
        onPressed: onPressed,
        highlightColor: Palette.text.withOpacity(0.05),
        splashColor: Palette.bg,
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
                fontSize: 14,
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
                        color: Palette.text,
                        fontFamily: "Kantumruy"),
                    children: [
                      TextSpan(
                        text: "${khNum(views.toString())}",
                      ),
                      TextSpan(
                        text: " ",
                        style: TextStyle(fontSize: 3),
                      ),
                      TextSpan(
                        text: "នាក់បានចូលមើល ",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w300,
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
  }

  Container hello(double width, List<String> question) {
    String name = "Sok";
    int index = Random().nextInt(question.length).toInt();
    print(index);
    return Container(
      width: width,
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "សួរស្តី​ $name",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          Text(
            question[index],
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
