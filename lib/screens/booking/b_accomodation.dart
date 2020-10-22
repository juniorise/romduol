import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/screens/booking/local_widget/date_picker.dart';
import 'package:romduol/screens/booking/local_widget/drop_down.dart';
import 'package:romduol/widget/theme/theme.dart';

class BookingAccomodation extends StatefulWidget {
  const BookingAccomodation({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;
  @override
  _BookingAccomodationState createState() => _BookingAccomodationState();
}

class AccBookModal {
  final int priceper1, datelength, priceTotal;

  AccBookModal({
    this.priceper1,
    this.datelength,
    this.priceTotal,
  });
}

class _BookingAccomodationState extends State<BookingAccomodation> {
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  Date startdate, enddate;

  int roomAmd = 0, bedAmd = 0;
  int _maxDateLength = 4;
  int bedPrice = 15, quantity = 1, total = 0;

  _selectDate({BuildContext context, bool isStart = false}) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: isStart ? DateTime.now() : selectedDate,
      lastDate: isStart
          ? Date().getLastMonth(selectedDate)
          : Date().getLastDate(selectedDate, _maxDateLength),
    );
    if (picked != null && picked != selectedDate && picked != selectedEndDate)
      setState(() {
        if (isStart) {
          selectedDate = picked;
          selectedEndDate = picked;
        } else
          selectedEndDate = picked;
      });
  }

  int getRecipt(int datelength) {
    int _quantity = 0, _pricetotal = 0;

    _quantity = bedAmd * roomAmd;
    _pricetotal = bedPrice * datelength * _quantity;

    return _pricetotal;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    startdate = Date().toKhDate(selectedDate, widget.isKH);
    enddate = Date().toKhDate(selectedEndDate, widget.isKH);

    int dateLength = Date().getLength(selectedDate, selectedEndDate);
    int res = getRecipt(dateLength);

    return Theme(
      data: ThemeData(fontFamily: widget.isKH ? "Kantumruy" : "Open Sans"),
      child: Scaffold(
        appBar: buildAppBar(
          title: widget.isKH ? "កក់កន្លែងស្នាក់នៅ" : "Booking accomodation",
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
                    Divider(),
                    SizedBox(height: 5),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        DatePickerCard(
                          isStart: true,
                          date: startdate,
                          isKH: widget.isKH,
                          onPressed: () =>
                              _selectDate(context: context, isStart: true),
                        ),
                        SizedBox(width: 10),
                        Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: Icon(
                            Icons.switch_left,
                            color: Palette.sky,
                          ),
                        ),
                        SizedBox(width: 5),
                        DatePickerCard(
                          isKH: widget.isKH,
                          date: enddate,
                          onPressed: () => _selectDate(context: context),
                        ),
                      ],
                    ),
                    SizedBox(height: 18),
                    DropdownCard(
                      width: width,
                      value: roomAmd,
                      total: 4,
                      endTitle: widget.isKH
                          ? "បន្ទប់"
                          : roomAmd < 2
                              ? "Room"
                              : "Rooms",
                      onTab: (i) => setState(() => roomAmd = i),
                      isKH: widget.isKH,
                    ),
                    SizedBox(height: 8),
                    DropdownCard(
                      width: width,
                      value: bedAmd,
                      total: 4,
                      endTitle: widget.isKH
                          ? "គ្រែ"
                          : bedAmd < 2
                              ? "Bed"
                              : "Beds",
                      onTab: (i) => setState(() => bedAmd = i),
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
                          buildWrap(widget.isKH ? "តម្លៃ/គ្រែ" : "Price/bed",
                              khNum(bedPrice.toString(), widget.isKH) + "\$"),
                          buildWrap(
                              widget.isKH
                                  ? "ចំនួនគ្រែ"
                                  : bedAmd < 2
                                      ? "Bed"
                                      : "Beds",
                              khNum(
                                  (bedAmd * roomAmd).toString(), widget.isKH)),
                          buildWrap(widget.isKH ? "ចំនួនថ្ងៃ" : "Total day",
                              khNum(dateLength.toString(), widget.isKH)),
                          buildWrap(widget.isKH ? "ប្រាក់សរុប" : "Total price",
                              khNum(res.toString(), widget.isKH) + "\$"),
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
                    )
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: Text(
                  'Term of services | Privacy',
                  style: TextStyle(
                    color: Palette.bgdark.withOpacity(0.6),
                    fontSize: 13,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
