import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/pagenotifier.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/data/data.dart';
import 'package:romduol/screens/widget/animatedtabbar.dart';
import 'dart:math' as math;

import 'package:romduol/screens/widget/fadeList.dart';

class Province extends StatefulWidget {
  final String province;

  const Province({Key key, @required this.province}) : super(key: key);

  @override
  _ProvinceState createState() => _ProvinceState();
}

class _ProvinceState extends State<Province>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  int currentPage = 0;
  ScrollController _scrollController;
  bool isSearching = false;

  @override
  void initState() {
    super.initState();

    _pageController = PageController(
      initialPage: currentPage,
      keepPage: true,
      viewportFraction: 1.0,
    );
    _scrollController = ScrollController(keepScrollOffset: true);
    _scrollController.addListener(listener);

    _pageController.addListener(pageControlerListener);
  }

  void listener() {}

  void pageControlerListener() {
    // double width;
    // if (_pageController.page == 1) {
    //   width = _pageController.offset;
    // }
    if (_pageController.position.isScrollingNotifier.value) {
      _scrollController.jumpTo(_pageController.offset * (0.19));
    }
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _pageController.dispose();
  }

  Widget _buildSearchField() {
    return new TextField(
      // controller: _searchQuery,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'ស្វែងរកក្នុងខេត្ត${widget.province}...',
        border: InputBorder.none,
        hintStyle: const TextStyle(
          color: Palette.text,
          fontSize: 14,
        ),
      ),
      style: const TextStyle(
        color: Palette.text,
        fontSize: 14.0,
      ),
      // onChanged: updateSearchQuery,
    );
  }

  void onSearchPressed() {
    setState(() {
      isSearching = !isSearching;
    });
  }

  Widget buildTitle() {
    return GestureDetector(
      onTap: onSearchPressed,
      child: Container(
        width: double.infinity,
        child: Text(
          "ស្វែងរកក្នុងខេត្ត${widget.province}...",
          style: TextStyle(fontSize: 14, color: Palette.sky),
          textAlign: TextAlign.start,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (e) => PageViewNotifier(_pageController),
      child: Scaffold(
        appBar: AppBar(
          titleSpacing: 0.0,
          elevation: 2.0,
          actions: [
            IconButton(
              icon: Icon(
                isSearching ? Icons.clear : Icons.search,
              ),
              onPressed: onSearchPressed,
            )
          ],
          title: isSearching ? _buildSearchField() : buildTitle(),
          bottom: PreferredSize(
            child: AnimatedTabBar(
              pageController: _pageController,
              currentPage: currentPage,
              scrollController: _scrollController,
            ),
            preferredSize: Size.fromHeight(50),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            setState(() {
              currentPage = page;
            });
          },
          children: <Widget>[
            FadeInOut(child: AnimatedLists(data: places), index: 0),
            FadeInOut(child: AnimatedLists(data: accomodations), index: 1),
            FadeInOut(child: AnimatedLists(data: places), index: 2),
            FadeInOut(child: AnimatedLists(data: places), index: 3),
          ],
        ),
      ),
    );
  }
}

class FadeInOut extends StatelessWidget {
  final Widget child;
  final int index;
  const FadeInOut({Key key, this.child, this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageViewNotifier>(
      builder: (context, notifier, child) {
        double opacity = 0;
        if (notifier.page > index)
          opacity = math.max(0, -notifier.page % 1);
        else if (notifier.page < index)
          opacity = math.max(0, notifier.page % 1);
        else if (notifier.page == index) opacity = 1;

        return Opacity(
          opacity: opacity,
          child: child,
        );
      },
      child: child,
    );
  }
}
