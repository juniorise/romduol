import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

Wrap buildWrap(String title, String subtitle) {
  return Wrap(
    direction: Axis.vertical,
    crossAxisAlignment: WrapCrossAlignment.center,
    children: [
      Text(
        title,
        style: TextStyle(
          color: Palette.bgdark.withOpacity(0.8),
          fontSize: 13,
        ),
      ),
      Text(
        subtitle,
        style: TextStyle(color: Palette.bgdark),
      ),
    ],
  );
}

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
      ),
    ],
    color: Colors.white,
  );
}

Container noData() {
  return Container(
    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
    decoration: buildBoxDecoration(),
    child: Center(
      child: Text(
        "គ្មានទិន្នន័យ",
        style: TextStyle(
          fontSize: 13,
          color: Palette.text,
        ),
      ),
    ),
  );
}

PreferredSize buildAppBar(
    {String title,
    Function onTab,
    bool isBlue = false,
    double elevation = 0.5}) {
  Color color = !isBlue ? Palette.sky : Colors.white;
  return PreferredSize(
    preferredSize: const Size.fromHeight(48),
    child: AppBar(
      elevation: elevation,
      backgroundColor: !isBlue ? Colors.white : Palette.sky,
      titleSpacing: 0.0,
      iconTheme: IconThemeData(color: color),
      title: Text(
        title,
        textAlign: TextAlign.start,
        style: TextStyle(color: color),
      ),
      actions: [
        onTab != null
            ? IconButton(
                icon: Icon(Icons.notifications),
                onPressed: onTab,
              )
            : SizedBox()
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

Container sectionTitle(
    {BuildContext context, String title, double padding = 5}) {
  return Container(
    padding: EdgeInsets.all(padding),
    width: MediaQuery.of(context).size.width,
    child: Text(
      title,
      textAlign: TextAlign.start,
      style: TextStyle(fontSize: 14, color: Palette.bgdark.withOpacity(0.8)),
    ),
  );
}
