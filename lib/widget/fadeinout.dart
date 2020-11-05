import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:math' as math;

import 'package:romduol/configs/pagenotifier.dart';

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
