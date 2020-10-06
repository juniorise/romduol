import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/pagenotifier.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/data/data.dart';
import 'package:romduol/screens/widget/animatedtabbar.dart';
import 'package:romduol/screens/widget/fadeList.dart';
import 'package:romduol/screens/widget/fadeinout.dart';

class Province extends StatefulWidget {
  final String province;
  const Province({Key key, @required this.province}) : super(key: key);
  @override
  _ProvinceState createState() => _ProvinceState();
}

class _ProvinceState extends State<Province>
    with SingleTickerProviderStateMixin {
  PageController _pageController;
  ScrollController _scrollController;
  bool isSearching = false;
  int currentPage = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
    _scrollController = ScrollController();
    _pageController.addListener(pageControllerListener);
  }

  List<bool> isAnimated = [false, true, true, true];
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (e) => PageViewNotifier(_pageController),
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(48 + 50.0),
          child: AppBar(
            titleSpacing: 0.0,
            elevation: 2.0,
            actions: [
              IconButton(
                icon: Icon(isSearching ? Icons.clear : Icons.search),
                onPressed: onSearchPressed,
              )
            ],
            title: isSearching ? _buildSearchField() : buildTitle(),
            bottom: PreferredSize(
              child: AnimatedTabBar(
                pageController: _pageController,
                currentPage: currentPage,
                scrollController: _scrollController,
                onTap: (index) => removeAnimated(index),
              ),
              preferredSize: Size.fromHeight(50),
            ),
          ),
        ),
        body: PageView(
          controller: _pageController,
          onPageChanged: (page) {
            itsAnimated(currentPage);
            setState(() => currentPage = page);
          },
          children: <Widget>[
            FadeInOut(
              index: 0,
              child: AnimatedLists(
                data: places,
                isAnimated: isAnimated[0],
              ),
            ),
            FadeInOut(
              index: 1,
              child: AnimatedLists(
                data: accomodations,
                isAnimated: isAnimated[1],
              ),
            ),
            FadeInOut(
              index: 2,
              child: AnimatedLists(
                data: places,
                isAnimated: isAnimated[2],
              ),
            ),
            FadeInOut(
              index: 3,
              child: AnimatedLists(
                data: places,
                isAnimated: isAnimated[3],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void itsAnimated(int index) {
    setState(() => isAnimated[index] = true);
    print("Page[${index.toString()}] is animated [${isAnimated[index]}]");
  }

  void removeAnimated(int index) {
    setState(() => isAnimated[index] = false);
    print("Page[${index.toString()}] is not animated [${isAnimated[index]}]");
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
    _pageController.dispose();
  }

  //check if page view is scrolling => animate scroller controller
  void pageControllerListener() {
    if (_pageController.position.isScrollingNotifier.value) {
      _scrollController.jumpTo(
        _pageController.offset * (0.19),
      );
    }
  }

  Widget _buildSearchField() {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'ស្វែងរកក្នុង${widget.province}...',
        border: InputBorder.none,
        hintStyle: const TextStyle(color: Palette.text, fontSize: 14),
      ),
      style: const TextStyle(
        color: Palette.text,
        fontSize: 14.0,
      ),
    );
  }

  void onSearchPressed() => setState(() => isSearching = !isSearching);

  Widget buildTitle() => GestureDetector(
        onTap: onSearchPressed,
        child: Container(
          width: double.infinity,
          child: Text(
            "ស្វែងរកក្នុង${widget.province}...",
            style: TextStyle(fontSize: 14, color: Palette.sky),
            textAlign: TextAlign.start,
          ),
        ),
      );
}
