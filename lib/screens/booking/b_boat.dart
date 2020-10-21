import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/screens/booking/local_widget/drop_down.dart';
import 'package:romduol/widget/theme/theme.dart';

class BookingBoat extends StatefulWidget {
  const BookingBoat({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;
  @override
  _BookingBoatState createState() => _BookingBoatState();
}

class _BookingBoatState extends State<BookingBoat> {
  DateTime selectedDate = DateTime.now();
  Date selectedDateKH;

  double boatPrice = 5;

  _selectDate({BuildContext context}) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime.now(),
        lastDate: Date().getLastMonth(selectedDate));
    if (picked != null && picked != selectedDate)
      setState(() => selectedDate = picked);
  }

  int peopleNum = 0;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    selectedDateKH = Date().toKhDate(
      selectedDate,
      widget.isKH,
    );
    return Scaffold(
      appBar: buildAppBar(title: "កក់ទូកដើរកំសាន្ត", isBlue: true, isKH: widget.isKH),
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
                    padding: 0,isKH: widget.isKH,
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    height: 48,
                    width: width,
                    decoration: buildBoxDecoration().copyWith(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: FlatButton(
                      padding: EdgeInsets.zero,
                      onPressed: () => _selectDate(context: context),
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
                  ),
                  SizedBox(height: 8),
                  DropdownCard(
                    width: width,
                    value: peopleNum,
                    total: 5,
                    endTitle: "នាក់",
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
                        buildWrap(
                          "តម្លៃ/នាក់",
                          khNum(boatPrice.toString() ?? '0', widget.isKH) +
                              "\$",
                        ),
                        buildWrap(
                          "ចំនួន",
                          khNum((peopleNum.toString()), widget.isKH) + " នាក់",
                        ),
                        buildWrap(
                          "ប្រាក់សរុប",
                          khNum((boatPrice * peopleNum).toString(),
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
                        "បញ្ជាក់",
                        style: TextStyle(color: Colors.white, fontSize: 13),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
