import 'package:flutter/material.dart';
import 'package:romduol/lang/lang.dart';

class HomeWecomeText extends StatelessWidget {
  const HomeWecomeText({
    Key key,
    @required this.isKH,
    @required this.isQuestionChanging,
    @required this.width,
    @required this.question,
    @required this.name,
  }) : super(key: key);

  final bool isKH;
  final bool isQuestionChanging;
  final double width;
  final String question;
  final String name;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    return Container(
      width: width,
      height: 100.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "${Lang().of(key: 'hello', isKH: isKH)}$name",
            style: TextStyle(
              fontSize: 16,
              color: color,
            ),
          ),
          AnimatedOpacity(
            opacity: isQuestionChanging ? 0 : 1,
            duration: Duration(milliseconds: 800),
            child: Text(
              question,
              style: TextStyle(
                fontSize: 14,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
