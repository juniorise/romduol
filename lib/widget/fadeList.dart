import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/cardOnProvince.dart';

class AnimatedLists extends StatefulWidget {
  const AnimatedLists({Key key, this.data, this.isAnimated = false})
      : super(key: key);
  final List<dynamic> data;
  final bool isAnimated;
  @override
  _AnimatedListsState createState() => _AnimatedListsState();
}

class _AnimatedListsState extends State<AnimatedLists> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    return Container(
      color: Palette.bg,
      width: width,
      height: height,
      child: LiveList.options(
        primary: true,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          dynamic data = widget.data[index];
          return FadeTransition(
            opacity: Tween<double>(
              begin: widget.isAnimated ? 1 : 0,
              end: 1,
            ).animate(animation),
            child: CardOnProvince(
              title: data.title,
              location: data.location,
              imageLocation: data.imageLocation,
              id: data.id,
              ratestar: data.ratestar,
              price: data.price,
            ),
          );
        },
        itemCount: widget.data.length,
        options: options,
      ),
    );
  }

  final options = LiveOptions(
    delay: Duration(seconds: 0),
    showItemInterval: Duration(milliseconds: 200),
    showItemDuration: Duration(milliseconds: 400),
  );
}
