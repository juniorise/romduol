import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/widget/card_province.dart';

class AnimatedLists extends StatefulWidget {
  const AnimatedLists(
      {Key key, this.data, this.isAnimated = false, @required this.isKH})
      : super(key: key);

  final List<CardModel> data;
  final bool isAnimated, isKH;
  @override
  _AnimatedListsState createState() => _AnimatedListsState();
}

class _AnimatedListsState extends State<AnimatedLists> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    double height = size.height;
    if (widget.data.length < 1)
      return Center(
        child: Text(
          "មិនមានទិន្នន័យ!",
          style: TextStyle(color: Palette.text),
        ),
      );
    return Container(
      color: Palette.bg,
      width: width,
      height: height,
      child: LiveList.options(
        physics: const AlwaysScrollableScrollPhysics(),
        primary: true,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          CardModel data = widget.data[index];
          return FadeTransition(
            opacity: Tween<double>(
              begin: widget.isAnimated ? 1 : 0,
              end: 1,
            ).animate(animation),
            child: CardOnProvince(data: data, isKH: widget.isKH,),
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
