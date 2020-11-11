import 'package:flutter/material.dart';
import 'package:preload_page_view/preload_page_view.dart';

class PageViewNotifier with ChangeNotifier{
  double _offset = 0;
  double _page = 0;

  
  PageViewNotifier(PreloadPageController _pageController){
    _pageController.addListener(() {
      _offset = _pageController.offset;
      _page = _pageController.page;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double get page => _page;
}