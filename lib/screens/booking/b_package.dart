import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/screens/booking/local_widget/drop_down.dart';
import 'package:romduol/widget/theme/theme.dart';

class BookingPackage extends StatefulWidget {
  const BookingPackage({Key key}) : super(key: key);

  @override
  _BookingPackageState createState() => _BookingPackageState();
}

class _BookingPackageState extends State<BookingPackage> {
  DateTime selectedDate = DateTime.now();
  Date selectedDateKH;

  int priceEach = 15, peopleNum = 0;

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    selectedDateKH = Date().toKhDate(selectedDate);
    return Scaffold(
      appBar: buildAppBar(title: "កក់កញ្ចប់ដំណើរកំសាន្ត", isBlue: true),
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              margin: EdgeInsets.zero,
              constraints: BoxConstraints(minHeight: height - 110),
              padding: EdgeInsets.all(20),
              width: width,
              child: Column(
                children: [
                  sectionTitle(
                    context: context,
                    title: "សូមបំពេញព័ត៏មានដើម្បីកក់",
                    padding: 0,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 48,
                    width: width,
                    decoration: buildBoxDecoration().copyWith(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20.0),
                          child: Text(
                            "${selectedDateKH.day} ${selectedDateKH.month} ${selectedDateKH.year}",
                            style: TextStyle(
                                color: Palette.bgdark, fontSize: 13),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Icon(
                            Icons.calendar_today,
                            size: 18,
                            color: Palette.bgdark.withOpacity(0.8),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  DropdownCard(
                    width: width,
                    value: peopleNum,
                    total: 10,
                    endTitle: "នាក់",
                    onTab: (i) => setState(() => peopleNum = i),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 75,
                    width: width,
                    decoration: buildBoxDecoration()
                        .copyWith(borderRadius: BorderRadius.circular(5)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        buildWrap(
                            "តម្លៃ/នាក់", khNum(priceEach.toString()) + "\$"),
                        buildWrap(
                          "ចំនួន",
                          khNum((peopleNum.toString())) + " នាក់",
                        ),
                        buildWrap(
                          "ប្រាក់សរុប",
                          khNum((priceEach * peopleNum).toString()) + "\$",
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8),
                  Container(
                    height: 50,
                    width: width,
                    decoration: buildBoxDecoration().copyWith(
                      borderRadius: BorderRadius.circular(5),
                      color: Palette.sky,
                    ),
                    child: FlatButton(
                      onPressed: () {},
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: Text(
                        "បញ្ជាក់",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class InfoTextIcon extends StatelessWidget {
  const InfoTextIcon({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.info,
          size: 14,
          color: Palette.bgdark.withOpacity(0.8),
        ),
        SizedBox(width: 4),
        Text(
          "ការកក់នឹងត្រូវបានផុតកំណត់ក្នុងរយ:ពេល ២ម៉ោង",
          style: TextStyle(
            color: Palette.bgdark.withOpacity(0.8),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}

class BikePickerCard extends StatelessWidget {
  const BikePickerCard({
    Key key,
    @required Animation<double> animation,
    @required this.width,
    this.isSelected = false,
    @required this.onPressed,
    this.price,
  })  : _animation = animation,
        super(key: key);

  final int price;
  final bool isSelected;
  final Function onPressed;
  final Animation<double> _animation;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          width: 115,
          height: 155,
          duration: Duration(milliseconds: 200),
          decoration: buildBoxDecoration().copyWith(
            border: Border.all(
              color: isSelected ? Palette.sky : Palette.bgdark.withOpacity(0.6),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10.0,
                spreadRadius: 0,
                offset: Offset(0, 4),
              ),
            ],
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
          child: FlatButton(
            padding: EdgeInsets.zero,
            highlightColor: Palette.sky.withOpacity(0.1),
            splashColor: Palette.sky.withOpacity(0.1),
            onPressed: onPressed,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: AnimatedContainer(
                    height: 28,
                    width: 115,
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(4)),
                      color: isSelected
                          ? Palette.sky
                          : Palette.bgdark.withOpacity(0.6),
                    ),
                    child: Text(
                      'កង់អេឡិចត្រូនិច',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: ClipRRect(
                    child: Transform.translate(
                      offset: Offset(_animation.value, 5),
                      child: Image.asset(
                        'assets/graphics/bike.png',
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 5,
                  child: Container(
                    width: width,
                    alignment: Alignment.center,
                    child: Text(
                      '${khNum(price.toString())}\$',
                      style: TextStyle(
                        fontSize: 13,
                        color: Palette.sky,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
