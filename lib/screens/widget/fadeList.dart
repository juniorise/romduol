import 'package:auto_animated/auto_animated.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/widget/cardOnProvince.dart';

class AnimatedLists extends StatefulWidget {
  const AnimatedLists({Key key, this.data}) : super(key: key);
  final List<dynamic> data;
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
        addAutomaticKeepAlives: false,
        itemBuilder: (
          BuildContext context,
          int index,
          Animation<double> animation,
        ) {
          return FadeTransition(
            opacity: Tween<double>(
              begin: 0,
              end: 1,
            ).animate(animation),

            // And slide transition
            child: SlideTransition(
              position: Tween<Offset>(
                begin: Offset(0, 0),
                end: Offset.zero,
              ).animate(animation),
              child: CardOnProvince(
                title: widget.data[index].title,
                location: widget.data[index].location,
                imageLocation: widget.data[index].imageLocation,
                id: widget.data[index].id,
                ratestar: widget.data[index].ratestar != null ? widget.data[index].ratestar : null,
                price: widget.data[index].price != null ? widget.data[index].price : null,
              ),
            ),
          );
        },
        itemCount: widget.data.length,
        options: options,
      ),
    );
  }

  final options = LiveOptions(
    // Start animation after (default zero)
    delay: Duration(seconds: 0),

    // Show each item through (default 250)
    showItemInterval: Duration(milliseconds: 200),

    // Animation duration (default 250)
    showItemDuration: Duration(milliseconds: 500),

    // Animations starts at 0.05 visible
    // item fraction in sight (default 0.025)
    visibleFraction: 0.05,

    // Repeat the animation of the appearance
    // when scrolling in the opposite direction (default false)
    // To get the effect as in a showcase for ListView, set true
    reAnimateOnVisibility: false,
  );
}
