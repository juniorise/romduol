import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/widget/card_province.dart';

class AnimatedLists extends StatefulWidget {
  const AnimatedLists(
      {Key key,
      this.data,
      this.isAnimated = false,
      @required this.isKH,
      this.onEditPressed,
      this.isIgnoring = false,
      this.onPop})
      : super(key: key);

  final List<CardModel> data;
  final bool isAnimated, isKH, isIgnoring;
  final List<Function> onEditPressed;
  final Function onPop;
  @override
  _AnimatedListsState createState() => _AnimatedListsState();
}

class _AnimatedListsState extends State<AnimatedLists> {
  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;
    double width = size.width;
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
      height: widget.data.length * 200.0,
      child: LiveList.options(
        physics: widget.isIgnoring
            ? NeverScrollableScrollPhysics()
            : AlwaysScrollableScrollPhysics(),
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
            child: Stack(
              alignment: Alignment.center,
              children: [
                CardOnProvince(
                  data: data,
                  isKH: widget.isKH,
                  onPop: widget.onPop,
                ),
                widget.onEditPressed != null
                    ? Positioned(
                        right: 20,
                        top: 8,
                        child: Container(
                          width: 40,
                          height: 40,
                          child: RaisedButton(
                            padding: EdgeInsets.zero,
                            highlightColor: Palette.sky,
                            child: Icon(Icons.edit, color: Colors.white),
                            color: Palette.bgdark.withOpacity(1),
                            onPressed: widget.onEditPressed[index],
                          ),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          );
        },
        itemCount: widget.data != null ? widget.data.length : 0,
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
