import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/widget/drop_down.dart';
import 'package:romduol/widget/theme.dart';

class BookingRestaurant extends StatefulWidget {
  const BookingRestaurant({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;
  @override
  _BookingRestaurantState createState() => _BookingRestaurantState();
}

class _BookingRestaurantState extends State<BookingRestaurant>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  Date selectedDateKH;
  Time selectedTimeKH;

  _selectDate({BuildContext context}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime.now(),
      lastDate: Date().getLastMonth(selectedDate),
    );
    if (picked != null && picked != selectedDate)
      setState(() => selectedDate = picked);
  }

  int tablePrice = 1, peopleNum = 0;

  _selectTime({BuildContext context}) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (picked != null && picked != selectedTime) {
      setState(() => selectedTime = picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    selectedDateKH = Date().toKhDate(selectedDate, widget.isKH);
    selectedTimeKH = Time().toSpecific(selectedTime, widget.isKH);
    return Theme(
      data: ThemeData(fontFamily: widget.isKH ? "Kantumruy" : "Open Sans"),
      child: Scaffold(
        appBar: buildAppBar(
            title: widget.isKH ? "កក់កន្លែងអង្គុយ" : "Book restaurant place", isBlue: true, isKH: widget.isKH),
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
                    Container(
                      height: 48,
                      width: width,
                      decoration: buildBoxDecoration().copyWith(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: FlatButton(
                        padding: EdgeInsets.zero,
                        onPressed: () => _selectTime(context: context),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "${khNum(selectedTimeKH.hour.toString(), widget.isKH)}:${khNum(selectedTimeKH.min.toString().padLeft(2, '0'), widget.isKH)} ${selectedTimeKH.status}",
                                style: TextStyle(
                                  color: Palette.bgdark,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 20.0),
                              child: Icon(
                                Icons.alarm,
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
                          buildWrap(widget.isKH ? "ថ្លៃកក់/តុ" : "Price/person",
                              khNum(tablePrice.toString(), widget.isKH) + "\$"),
                          buildWrap(
                            widget.isKH ? "ចំនួន" : "Total person",
                            khNum((peopleNum.toString()), widget.isKH),
                          ),
                          buildWrap(
                            widget.isKH ? "ប្រាក់សរុប" : "Total price",
                            khNum((tablePrice * peopleNum).toString(),
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
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info,
                          size: 14,
                          color: Palette.bgdark.withOpacity(0.8),
                        ),
                        SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            Lang().of(key: "restuarantexpire", isKH: widget.isKH),
                            style: TextStyle(
                              color: Palette.bgdark.withOpacity(0.8),
                              fontSize: 13,
                            ),
                          ),
                        ),
                      ],
                    ),
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
