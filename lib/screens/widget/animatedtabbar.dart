import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

class AnimatedTabBar extends StatefulWidget {
  final PageController pageController;

  const AnimatedTabBar({Key key, this.pageController}) : super(key: key);

  @override
  _AnimatedTabBarState createState() => _AnimatedTabBarState();
}

class _AnimatedTabBarState extends State<AnimatedTabBar> {
  List<String> _tabBarNames = [
    "ទីកន្លែង",
    "កន្លែងស្នាក់នៅ",
    "សកម្មភាព",
    "អាហារ"
  ];

  ScrollController _scrollController;

  int _pageIndex = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController(keepScrollOffset: true);
    _scrollController.addListener(listener);
  }

  void listener() {
    print(_scrollController.offset);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double width = size.width;
    // double height = size.height;
    return Container(
      width: width,
      height: 42,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: ListView(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        children: _buildTabBarList(),
      ),
    );
  }

  List<Widget> _buildTabBarList() {
    List<Widget> _tabItem = List();
    for (int i = 0; i < _tabBarNames.length; i++) {
      bool _isSelected = i == _pageIndex;
      _tabItem.insert(
        i,
        GestureDetector(
          onTap: () {
            setState(() {
              _pageIndex = i;
              widget.pageController.jumpToPage(i);
            });
          },
          child: AnimatedContainer(
            width: 150,
            duration: Duration(milliseconds: 300),
            margin: EdgeInsets.only(
              left: i == 0 ? 10 : 5,
              right: i == _tabBarNames.length - 1 ? 10 : 5,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color:
                  _isSelected ? Palette.sky : Palette.bggrey.withOpacity(0.3),
            ),
            child: Text(
              _tabBarNames[i],
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 12,
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
