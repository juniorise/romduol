import 'package:flutter/material.dart';

Center loading() {
  return Center(
    heightFactor: 1,
    child: Container(
      width: 30,
      height: 30,
      child: CircularProgressIndicator(),
    ),
  );
}

BoxDecoration buildBoxDecoration() {
  return BoxDecoration(
    boxShadow: [
      BoxShadow(
        color: Colors.black87.withOpacity(0.1),
        blurRadius: 1.0,
        offset: Offset(0, 0),
      )
    ],
    color: Colors.white,
  );
}

Container noData() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: buildBoxDecoration(),
    child: Text(
      "គ្មានទិន្នន័យ",
      style: TextStyle(
        fontSize: 13,
        color: Palette.text,
      ),
    ),
  );
}

PreferredSize buildAppBar(BuildContext context, String title) {
  Color color = Palette.sky;
  return PreferredSize(
    preferredSize: const Size.fromHeight(48),
    child: AppBar(
      elevation: 0.3,
      backgroundColor: Colors.white.withOpacity(0.8),
      titleSpacing: 0.0,
      iconTheme: IconThemeData(color: color),
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(color: color),
      ),
      actions: [
        IconButton(
          icon: Icon(Icons.notifications),
          onPressed: () {},
        )
      ],
    ),
  );
}

String khNum(String input) {
  const english = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];
  const farsi = ['០', '១', '២', '៣', '៤', '៥', '៦', '៧', '៨', '៩'];

  for (int i = 0; i < english.length; i++) {
    input = input.replaceAll(english[i], farsi[i]);
  }

  return input;
}

class Palette {
  static Map<int, Color> color = {
    50: Color.fromRGBO(136, 14, 79, .1),
    100: Color.fromRGBO(136, 14, 79, .2),
    200: Color.fromRGBO(136, 14, 79, .3),
    300: Color.fromRGBO(136, 14, 79, .4),
    400: Color.fromRGBO(136, 14, 79, .5),
    500: Color.fromRGBO(136, 14, 79, .6),
    600: Color.fromRGBO(136, 14, 79, .7),
    700: Color.fromRGBO(136, 14, 79, .8),
    800: Color.fromRGBO(136, 14, 79, .9),
    900: Color.fromRGBO(136, 14, 79, 1),
  };

  //0xAARRGGBB
  static MaterialColor appbar = MaterialColor(0xFFFFFFFF, color);
  //Color.fromRGBO(23, 38, 52, 100),
  static MaterialColor background = MaterialColor(0xFFF8F8F8, color);
  //Color.fromRGBO(22, 31, 40, 100),

  static const Color red = Color(0xFFEF6177);
  //Color.fromRGBO(239, 98, 119, 100),
  static const Color sky = Color(0xFF42A5F5);
  //Color.fromRGBO(66, 165, 245, 100),
  static const Color yellow = Color(0xFFF1C933);
  //Color.fromRGBO(241, 201, 51, 100),

  static const Color text = Color(0xFF686868);
  static const Color bggrey = Color(0xFFA6A6A6);
  static const Color bg = Color(0xFFF8F8F8);
  static const Color bgdark = Color(0xFF04222C);

  static const Color sea = Color(0xFF2FBABF);
  static const Color sky90 = Color.fromRGBO(66, 165, 245, .9);
  static const Color sky80 = Color.fromRGBO(66, 165, 245, .8);
  static const Color sky70 = Color.fromRGBO(66, 165, 245, .7);
  static const Color sky60 = Color.fromRGBO(66, 165, 245, .6);
  static const Color sky50 = Color.fromRGBO(66, 165, 245, .5);

  static const Color yellow90 = Color.fromRGBO(241, 201, 51, .9);
  static const Color yellow80 = Color.fromRGBO(241, 201, 51, .8);
  static const Color yellow70 = Color.fromRGBO(241, 201, 51, .7);
  static const Color yellow60 = Color.fromRGBO(241, 201, 51, .6);
  static const Color yellow50 = Color.fromRGBO(241, 201, 51, .5);

  static const Color white90 = Color.fromRGBO(255, 255, 255, .9);
  static const Color white80 = Color.fromRGBO(255, 255, 255, .8);
  static const Color white70 = Color.fromRGBO(255, 255, 255, .7);
  static const Color white60 = Color.fromRGBO(255, 255, 255, .6);
  static const Color white50 = Color.fromRGBO(255, 255, 255, .5);
  static const Color white40 = Color.fromRGBO(255, 255, 255, .4);
  static const Color white30 = Color.fromRGBO(255, 255, 255, .3);
  static const Color white20 = Color.fromRGBO(255, 255, 255, .2);
  static const Color white10 = Color.fromRGBO(255, 255, 255, .1);
}
