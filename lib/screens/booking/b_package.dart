import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/widget/drop_down.dart';
import 'package:romduol/widget/theme.dart';

class BookingPackage extends StatefulWidget {
  const BookingPackage({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;
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

    selectedDateKH = Date().toKhDate(selectedDate, widget.isKH);
    return Theme(
      data: ThemeData(fontFamily: widget.isKH ? "Kantumruy" : "Open Sans"),
      child: Scaffold(
        appBar: buildAppBar(
          title: widget.isKH ? "កក់កញ្ចប់ដំណើរកំសាន្ត" : "Booking tour package",
          isBlue: true,
          isKH: widget.isKH,
        ),
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
                      title: Lang().of(key: "bookingheader", isKH: widget.isKH),
                      padding: 0,
                      isKH: widget.isKH,
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
                      endTitle: widget.isKH
                          ? "នាក់"
                          : peopleNum < 2
                              ? "person"
                              : "people",
                      onTab: (i) => setState(() => peopleNum = i),
                      isKH: widget.isKH,
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
                          buildWrap(widget.isKH ? "តម្លៃ/នាក់" : "Price/person",
                              khNum(priceEach.toString(), widget.isKH) + "\$"),
                          buildWrap(
                            widget.isKH
                                ? "ចំនួន"
                                : peopleNum < 2
                                    ? "Person"
                                    : "People",
                            widget.isKH
                                ? khNum((peopleNum.toString()), widget.isKH) +
                                    " នាក់"
                                : khNum((peopleNum.toString()), widget.isKH),
                          ),
                          buildWrap(
                            widget.isKH ? "ប្រាក់សរុប" : "Total price",
                            khNum((priceEach * peopleNum).toString(),
                                    widget.isKH) +
                                "\$",
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
                          Lang().of(key: "confirm", isKH: widget.isKH),
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
