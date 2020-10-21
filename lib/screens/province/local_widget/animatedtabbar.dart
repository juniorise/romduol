import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/lang/lang.dart';

class AnimatedTabBar extends StatefulWidget {
  final PageController pageController;
  final int currentPage;
  final ScrollController scrollController;
  final Function onTap;
  final bool isKH;

  const AnimatedTabBar({
    Key key,
    this.pageController,
    this.currentPage,
    this.scrollController,
    this.onTap,
    @required this.isKH,
  }) : super(key: key);

  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    // double height = size.height;
    return Container(
      width: width,
      height: 38,
      margin: const EdgeInsets.only(bottom: 8.0),
      child: ListView(
        physics: BouncingScrollPhysics(),
        shrinkWrap: true,
        dragStartBehavior: DragStartBehavior.down,
        controller: widget.scrollController,
        scrollDirection: Axis.horizontal,
        children: _buildTabBarList(),
      ),
    );
  }

  List<Widget> _buildTabBarList() {
    List<String> _tabBarNames = [
      Lang().of(key: 'place', isKH: widget.isKH),
      Lang().of(key: 'accomodation', isKH: widget.isKH),
      Lang().of(key: 'activities', isKH: widget.isKH),
      Lang().of(key: 'restaurant', isKH: widget.isKH),
    ];

    List<Widget> _tabItem = List();
    for (int i = 0; i < _tabBarNames.length; i++) {
      bool _isSelected = i == widget.currentPage;
      _tabItem.add(
        AnimatedContainer(
          width: 130,
          duration: Duration(milliseconds: 150),
          margin: EdgeInsets.only(
            left: i == 0 ? 10 : 5,
            right: i == _tabBarNames.length - 1 ? 10 : 5,
          ),
          padding: EdgeInsets.zero,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color:
                  _isSelected ? Palette.sky : Palette.bggrey.withOpacity(0.15)),
          child: FlatButton(
            height: double.infinity,
            minWidth: 130,
            splashColor: Palette.bggrey.withOpacity(0.08),
            highlightColor: Palette.bggrey.withOpacity(0.01),
            onPressed: () {
              widget.onTap(i);
              setState(() {
                widget.scrollController.animateTo(
                  68.4 * i,
                  duration: Duration(milliseconds: 200),
                  curve: Curves.ease,
                );
                widget.pageController.jumpToPage(i);
              });
            },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            child: Text(
              _tabBarNames[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
                fontFamily: widget.isKH ? 'Kantumruy' : 'Open Sans',
                color: !_isSelected ? Palette.sky : Colors.white,
              ),
            ),
          ),
        ),
      );
    }
    return _tabItem;
  }
}
