import 'package:flutter/material.dart';

class TabViewNotifier with ChangeNotifier{
  double _offset = 0;
  int _index = 0;

  
  TabViewNotifier(TabController _tabController){
    _tabController.addListener(() {
      _offset = _tabController.offset;
      _index = _tabController.index;
      notifyListeners();
    });
  }

  double get offset => _offset;
  int get index => _index;
}