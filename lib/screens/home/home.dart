import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/home/background.jpg',
          fit: BoxFit.cover,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: buildAppBar(),
          body: ListView(
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: sectionTitle(
                          width: width,
                          title: "សូមជ្រើសរើសខេតណាមួយនៃតំបន់ឆ្នេរ"),
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProvinceCard(
                          province: "ខេត្តកំពត",
                          location: "ទីតាំងស្ថិតនៅក្នុងខេត្តកំពត",
                          imagelocation: "assets/provinces/kompot.png",
                          onPressed: () {},
                          context: context,
                        ),
                        SizedBox(width: 10),
                        buildProvinceCard(
                          province: "ខេត្តកោះកុង",
                          location: "ទីតាំងស្ថិតនៅក្នុងខេត្តកំពត",
                          imagelocation: "assets/provinces/kohkong.png",
                          onPressed: () {},
                          context: context,
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildProvinceCard(
                          province: "ខេត្តព្រះសីហនុ",
                          location: "ទីតាំងស្ថិតនៅក្នុងខេត្តកំពត",
                          imagelocation: "assets/provinces/sihanouk.png",
                          onPressed: () {},
                          context: context,
                        ),
                        SizedBox(width: 10),
                        buildProvinceCard(
                          province: "ខេត្តកែប",
                          location: "ទីតាំងស្ថិតនៅក្នុងខេត្តកំពត",
                          imagelocation: "assets/provinces/kep.png",
                          onPressed: () {},
                          context: context,
                        )
                      ],
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
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: posterCard(width),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5.0),
                      child: sectionTitle(
                        width: width,
                        title: "ចូលរួមជាមួយពួកយើង",
                      ),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        packageCard(
                          width: width,
                          imagelocation: "assets/provinces/kompot.png",
                          total: 25,
                          booked: 8,
                          title: "ភ្នំបូកគោបោះតង់2ថ្ងៃ1យប់",
                          location: "ខេត្តកំពត",
                          date: "10-11 កញ្ញា 2021",
                          price: 25,
                        ),
                        Divider(),
                        packageCard(
                          width: width,
                          imagelocation: "assets/activities/kompot/kohrong.png",
                          total: 35,
                          booked: 16,
                          title: "ដំណើរកំសាន្តទៅកាន់កោះរុង3ថ្ងៃ",
                          location: "កោះកុង",
                          date: "18-21 កញ្ញា 2021",
                          price: 35,
                        ),
                        Divider(),
                        packageCard(
                          width: width,
                          imagelocation:
                              "assets/activities/kompot/mountain.png",
                          total: 40,
                          booked: 15,
                          title: "ដំណើរកំសាន្តដើរព្រៃនៅកំពត",
                          location: "ខេត្តកំពត",
                          date: "30-2 តុលា 2021",
                          price: 15,
                        ),
                        Divider(),
                        packageCard(
                          width: width,
                          imagelocation: "assets/activities/kompot/bostong.png",
                          total: 25,
                          booked: 18,
                          title: "ភ្នំបូកគោបោះតង់2ថ្ងៃ1យប់",
                          location: "ខេត្តព្រះសីហនុ",
                          date: "10-11 តុលា 2021",
                          price: 25,
                        ),
                        Divider(),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ],
    );
  }

  Container packageCard({
    double width,
    String imagelocation,
    int total,
    int booked,
    String title,
    String location,
    String date,
    int price,
  }) {
    return Container(
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
                        ),
                        children: [
                          TextSpan(
                            text: "$booked",
                            style: TextStyle(fontSize: 14),
                          ),
                          TextSpan(
                            text: "/$total នាក់",
                            style: TextStyle(fontSize: 12),
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
                          style: TextStyle(fontSize: 14, color: Palette.text),
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
                      Wrap(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: Palette.red,
                            size: 16,
                          ),
                          Text(
                            location,
                            style: TextStyle(
                              fontSize: 12,
                              color: Palette.text.withOpacity(0.8),
                            ),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          vertical: 0,
                          horizontal: 5,
                        ),
                        color: Palette.text.withOpacity(0.1),
                        child: Text(
                          date,
                          style: TextStyle(fontSize: 12, color: Palette.text),
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
                    padding: const EdgeInsets.only(left: 20.0),
                    child: Text(
                      "អេកូ-កញ្ចប់ដំណើរកំសាន្ត",
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Container(
                    width: width,
                    color: Palette.sky70,
                    padding: EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 15,
                    ),
                    child: Text(
                      "ដំណើរកំសាន្តប្រកបដោយចីរភាព សន្សំសច្ចៃ និង មានសុវត្តិភាព",
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white,
                      ),
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

  Container sectionTitle({double width, String title}) {
    return Container(
      width: width,
      child: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(fontSize: 16, color: Palette.text),
      ),
    );
  }

  FlatButton buildProvinceCard(
      {String province,
      String location,
      Function onPressed,
      String imagelocation,
      BuildContext context}) {
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
              style: TextStyle(fontSize: 14, color: Palette.text, fontWeight: FontWeight.w400),
            ),
            Text(
              location,
              style:
                  TextStyle(fontSize: 12, color: Palette.text.withOpacity(0.6)),
            ),
          ],
        ),
      ),
    );
  }

  Container hello(double width) {
    return Container(
      width: width,
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "សួរស្តី​ Sok",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          Text(
            "តើអ្នកចង់ទៅដំណើរកំសាន្តឯណាដែរ?",
            style: TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Palette.white80,
      automaticallyImplyLeading: false,
      titleSpacing: 0.0,
      title: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          IconButton(
            icon: Icon(
              Icons.menu,
              color: Palette.sky,
              size: 24,
            ),
            onPressed: () {},
          ),
          Text(
            "រុករក",
            style: TextStyle(fontSize: 16, color: Palette.sky),
            textAlign: TextAlign.start,
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.notifications,
            color: Palette.sky,
            size: 24,
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
