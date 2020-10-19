import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/screens/booking/local_widget/drop_down.dart';
import 'package:romduol/widget/theme/theme.dart';

class BookingRestaurant extends StatefulWidget {
  const BookingRestaurant({Key key}) : super(key: key);

  @override
  _BookingRestaurantState createState() => _BookingRestaurantState();
}

class Time {
  final int hour, min, sec;
  final String status;
  Time({this.hour, this.min, this.sec, this.status});

  Time toSpecific(TimeOfDay time) {
    int _hour = 0, _min = 0, _sec = 0;
    String _status = "ព្រឺក";

    _hour = time.hour;

    if (time.minute >= 0 && time.minute < 15) {
      _min = 0;
    }

    if (time.minute >= 15 && time.minute < 30) {
      _min = 15;
    }

    if (time.minute >= 30 && time.minute < 45) {
      _min = 30;
    }

    if (time.minute >= 45 && time.minute < 50) {
      _min = 45;
    }

    if (time.minute >= 50) {
      _min = 0;
      _hour += 1;
    }

    if (_hour > 12) {
      _hour -= 12;
      _status = "ល្ងាច";
    }

    return Time(hour: _hour, min: _min, sec: _sec, status: _status);
  }
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

    selectedDateKH = Date().toKhDate(selectedDate);
    selectedTimeKH = Time().toSpecific(selectedTime);
    return Scaffold(
      appBar: buildAppBar(title: "កក់កង់", isBlue: true),
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
                              "${khNum(selectedTimeKH.hour.toString())}:${khNum(selectedTimeKH.min.toString().padLeft(2, '0'))} ${selectedTimeKH.status}",
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
                            "ថ្លៃកក់/តុ", khNum(tablePrice.toString()) + "\$"),
                        buildWrap(
                          "ចំនួន",
                          khNum((peopleNum.toString())),
                        ),
                        buildWrap(
                          "ប្រាក់សរុប",
                          khNum((tablePrice * peopleNum).toString()) + "\$",
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
                  Row(
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
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
