import 'package:flutter/material.dart';

class ScrollNotifier with ChangeNotifier{
  double _offset = 0;
  double _init = 0;
  
  ScrollNotifier(ScrollController _scrollController){
    _scrollController.addListener(() {
      _offset = _scrollController.offset;
      _init = _scrollController.initialScrollOffset;
      notifyListeners();
    });
  }

  double get offset => _offset;
  double get init => _init;
}