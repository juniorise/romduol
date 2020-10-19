import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/date.dart';
import 'package:romduol/screens/booking/local_widget/drop_down.dart';
import 'package:romduol/widget/theme/theme.dart';

class BookingBike extends StatefulWidget {
  const BookingBike({Key key}) : super(key: key);

  @override
  _BookingBikeState createState() => _BookingBikeState();
}

class _BookingBikeState extends State<BookingBike>
    with SingleTickerProviderStateMixin {
  DateTime selectedDate = DateTime.now();
  Date selectedDateKH;

  Animation<double> _animation;
  Animation<double> _animation2;
  AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    _animation = Tween<double>(begin: 100, end: 20).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController))
      ..addListener(() {
        setState(() {});
      });

    _animation2 = Tween<double>(begin: 200, end: 20).animate(
        CurvedAnimation(curve: Curves.easeInOut, parent: _animationController))
      ..addListener(() {
        setState(() {});
      });

    _animationController.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  _selectDate({BuildContext context}) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate, // Refer step 1
        firstDate: DateTime.now(),
        lastDate: Date().getLastMonth(selectedDate));
    if (picked != null && picked != selectedDate)
      setState(() => selectedDate = picked);
  }

  bool isSelectedA = false, isSelectedB = false;
  int bikeNum = 0, bikeAPrice = 5, bikeBPrice = 7;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    selectedDateKH = Date().toKhDate(selectedDate);
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
                  SizedBox(height: 18.0),
                  sectionTitle(
                    context: context,
                    title: "ជ្រើសរើសប្រភេទកង់",
                    padding: 0,
                  ),
                  SizedBox(height: 12.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BikePickerCard(
                          animation: _animation,
                          width: width,
                          isSelected: isSelectedA,
                          price: bikeAPrice,
                          onPressed: () {
                            if (!isSelectedA) {
                              setState(() {
                                isSelectedA = !isSelectedA;
                                isSelectedB = !isSelectedA;
                              });
                            }
                          }),
                      SizedBox(width: 24),
                      BikePickerCard(
                        animation: _animation2,
                        width: width,
                        isSelected: isSelectedB,
                        price: bikeBPrice,
                        onPressed: () {
                          if (!isSelectedB) {
                            setState(() {
                              isSelectedB = !isSelectedB;
                              isSelectedA = !isSelectedB;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 18),
                  DropdownCard(
                    width: width,
                    value: bikeNum,
                    total: 5,
                    endTitle: "កង់",
                    onTab: (i) => setState(() => bikeNum = i),
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
                            "តម្លៃ/កង់",
                            khNum(isSelectedA
                                    ? bikeAPrice.toString()
                                    : isSelectedB
                                        ? bikeBPrice.toString()
                                        : '0') +
                                "\$"),
                        buildWrap(
                          "ចំនួនកង",
                          khNum((bikeNum.toString())),
                        ),
                        buildWrap(
                          "ប្រាក់សរុប",
                          khNum((isSelectedA
                                      ? bikeAPrice * bikeNum
                                      : isSelectedB
                                          ? bikeBPrice * bikeNum
                                          : 0)
                                  .toString()) +
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
