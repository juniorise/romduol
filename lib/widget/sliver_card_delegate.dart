
import 'package:flutter/material.dart';

class SliverCardDelegate extends SliverPersistentHeaderDelegate {
  SliverCardDelegate({this.child, this.height});

  final Widget child;
  final double height;

  @override
  double get minExtent => height + 10;
  @override
  double get maxExtent => height + 10;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white, child: child);
  }

  @override
  bool shouldRebuild(SliverCardDelegate oldDelegate) {
    return false;
  }
}
