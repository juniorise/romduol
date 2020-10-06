import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/data/data.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/province.dart';
import 'package:romduol/screens/widget/location.dart';

class HomePage extends StatefulWidget {
  final Function onTab;
  const HomePage({Key key, this.onTab}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(context),
      extendBodyBehindAppBar: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset("assets/home/background.jpg", fit: BoxFit.cover),
          ListView(
            children: [
              //HELLO TITLE
              hello(width),

              //PROVINCES
              Container(
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                color: Colors.white,
                width: width,
                child: Column(
                  children: [
                    sectionTitle("សូមជ្រើសរើសខេត្តណាមួយនៃតំបន់ឆ្នេរ"),
                    Container(
                      height: 300,
                      width: width,
                      child: LiveGrid.options(
                        physics: NeverScrollableScrollPhysics(),
                        options: options,
                        addAutomaticKeepAlives: false,
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
                              location: data.location,
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
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 10,
                            childAspectRatio: 1.1),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.0),

              //ECO TRAVEL PACKAGE
              Container(
                color: Colors.white,
                padding: EdgeInsets.all(15),
                width: width,
                child: Column(
                  children: [
                    posterCard(width),
                    SizedBox(height: 5),
                    sectionTitle("ចូលរួមជាមួយពួកយើង"),
                    Column(
                      children: [
                        for (PackageModel data in packages)
                          packageCard(
                            width: width,
                            imagelocation: data.imagelocation,
                            total: data.total,
                            booked: data.booked,
                            title: data.title,
                            location: data.location,
                            date: data.date,
                            price: data.price,
                          )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ],
      ),
    );
  }

  final options = LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 200),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 500),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: true,
  );
  Column packageCard({
    double width,
    String imagelocation,
    int total,
    int booked,
    String title,
    String location,
    String date,
    int price,
  }) {
    return Column(
      children: [
        Container(
          //package container
          width: width,
          child: FlatButton(
            onPressed: () {},
            padding: EdgeInsets.symmetric(vertical: 5, horizontal: 0),
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                Stack(
                  //left side - image + booked/total people join
                  children: [
                    Image.asset(
                      imagelocation,
                      width: 110,
                      height: 60,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      bottom: 5,
                      left: 0,
                      child: Container(
                        width: 75,
                        color: Colors.white.withOpacity(0.8),
                        padding: EdgeInsets.all(3),
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: TextStyle(
                              color: Palette.sky,
                              fontWeight: FontWeight.normal,
                              fontFamily: "Kantumruy",
                            ),
                            children: [
                              TextSpan(
                                text: "$booked",
                                style: TextStyle(fontSize: 14),
                              ),
                              TextSpan(
                                text: "/$total នាក់",
                                style: TextStyle(
                                  fontSize: 12,
                                ),
                              )
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
                          Container(
                            width: width - 110 - 40 - 10 - 25,
                            child: Text(
                              title,
                              style:
                                  TextStyle(fontSize: 14, color: Palette.text),
                            ),
                          ),
                          Text(
                            "$price\$",
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
                          LocationText(location: location),
                          Container(
                            padding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 5,
                            ),
                            color: Palette.text.withOpacity(0.1),
                            child: Text(
                              date,
                              style:
                                  TextStyle(fontSize: 12, color: Palette.text),
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
      child: Stack(
        fit: StackFit.expand,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.asset(
              "assets/activities/kompot/bostong.png",
              fit: BoxFit.cover,
            ),
          ),
          FlatButton(
            onPressed: () {},
            padding: EdgeInsets.zero,
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
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
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "អេកូ-កញ្ចប់ដំណើរកំសាន្ត",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                  Container(
                    width: width,
                    color: Palette.sky70,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      "ដំណើរកំសាន្តប្រកបដោយចីរភាព សន្សំសច្ចៃ និង មានសុវត្តិភាព",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
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

  FlatButton buildProvinceCard({
    String province,
    String location,
    Function onPressed,
    String imagelocation,
    BuildContext context,
  }) {
    double width = MediaQuery.of(context).size.width;
    return FlatButton(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
      onPressed: onPressed,
      child: Container(
        width: (width - 60) / 2,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              imagelocation,
              height: 80,
              fit: BoxFit.cover,
              width: (width - 60) / 2,
            ),
            SizedBox(height: 5.0),
            Text(
              province,
              style: TextStyle(
                fontSize: 14,
                color: Palette.text,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              location,
              style: TextStyle(
                fontSize: 12,
                color: Palette.text.withOpacity(0.6),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container hello(double width) {
    String name = "Sok";
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
              fontFamily: "Kantumruy",
              color: Colors.white,
            ),
          ),
          Text(
            "តើអ្នកចង់ទៅដំណើរកំសាន្តឯណាដែរ?",
            style: TextStyle(fontSize: 14, color: Colors.white),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Palette.white90,
      titleSpacing: 0.0,
      title: Text("រុករក", textAlign: TextAlign.start),
      leading: IconButton(
        icon: Icon(Icons.menu, size: 24),
        onPressed: widget.onTab,
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        )
      ],
    );
  }
}
