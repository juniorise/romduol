import 'package:flutter/material.dart';

class PageViewNotifier with ChangeNotifier{
  double _offset = 0;
  double _page = 0;
  double init;
  
  PageViewNotifier(PageController _pageController){
    _pageController.addListener(() {
      _offset = _pageController.offset;
      _page = _pageController.page;
      init = _pageController.initialScrollOffset;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double get page => _page;
}