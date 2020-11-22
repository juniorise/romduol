import 'package:flutter/material.dart';

class ScaleDownOnTab extends StatefulWidget {
  const ScaleDownOnTab({Key key, @required this.child, @required this.onTab})
      : super(key: key);

  final Function onTab;
  final Widget child;
  @override
  _ScaleDownOnTabState createState() => _ScaleDownOnTabState();
}

class _ScaleDownOnTabState extends State<ScaleDownOnTab>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 100),
      vsync: this,
    );

    _animation = Tween<double>(begin: 1, end: 0.98).animate(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (val) {
        _controller.forward();
      },
      onTapCancel: () {
        _controller.reverse();
      },
      onTapUp: (val) {
        _controller.reverse();
      },
      onTap: () {
        widget.onTab();
      },
      child: ScaleTransition(
        scale: _animation,
        child: widget.child,
      ),
    );
  }
}
