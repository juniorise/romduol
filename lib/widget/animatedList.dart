import 'package:auto_animated/auto_animated.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/services/user_data.dart';
import 'package:romduol/widget/card_province.dart';
import 'package:romduol/widget/theme.dart';

class AnimatedLists extends StatefulWidget {
  const AnimatedLists(
      {Key key,
      this.data,
      this.isAnimated = false,
      @required this.isKH,
      this.onEditPressed,
      this.isIgnoring = false,
      this.onPop})
      : super(key: key);

  final List<CardModel> data;
  final bool isAnimated, isKH, isIgnoring;
  final List<Function> onEditPressed;
  final Function onPop;
  @override
  _AnimatedListsState createState() => _AnimatedListsState();
}

class _AnimatedListsState extends State<AnimatedLists> {
  @override
  Widget build(BuildContext context) {
    FirebaseAuth _auth = FirebaseAuth.instance;

    Size size = MediaQuery.of(context).size;
    double width = size.width;
    if (widget.data.length == 0)
      return Center(
        child: Text(
          "មិនមានទិន្នន័យ!",
          style: TextStyle(color: Palette.text),
        ),
      );
    else if (widget.data.length > 0)
      return StreamBuilder<UserData>(
          stream: UserDatabase(
                  uid: _auth.currentUser != null ? _auth.currentUser.uid : null)
              .userData,
          builder: (context, snapshot) {
            return Container(
              color: Palette.bg,
              height: widget.isIgnoring
                  ? MediaQuery.of(context).size.height - 48 - 48 - 33
                  : MediaQuery.of(context).size.height - 48,
              width: width,
              child: LiveList.options(
                primary: true,
                itemBuilder: (
                  BuildContext context,
                  int index,
                  Animation<double> animation,
                ) {
                  CardModel data = widget.data[index];
                  return Container(
                    margin: EdgeInsets.only(
                      bottom: index == widget.data.length - 1 ? 10 : 0,
                    ),
                    child: FadeTransition(
                      opacity: Tween<double>(
                        begin: widget.isAnimated ? 1 : 0,
                        end: 1,
                      ).animate(animation),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CardOnProvince(
                            data: data,
                            isKH: widget.isKH,
                            onPop: widget.onPop,
                            index: index,
                          ),
                          widget.onEditPressed != null &&
                                  snapshot.data != null &&
                                  snapshot.data.role == "Admin"
                              ? Positioned(
                                  right: 23,
                                  top: 13,
                                  child: ClipOval(
                                    child: Container(
                                      width: 40,
                                      height: 40,
                                      child: RaisedButton(
                                        padding: EdgeInsets.zero,
                                        child: Icon(
                                          Icons.edit,
                                          color: Palette.bgdark.withOpacity(1),
                                        ),
                                        highlightColor:
                                            Palette.bgdark.withOpacity(0.2),
                                        color: Colors.white,
                                        onPressed: widget.onEditPressed[index],
                                      ),
                                    ),
                                  ),
                                )
                              : SizedBox()
                        ],
                      ),
                    ),
                  );
                },
                itemCount: widget.data != null ? widget.data.length : 0,
                options: options,
              ),
            );
          });
    return loading();
  }

  final options = LiveOptions(
    delay: Duration(seconds: 0),
    showItemInterval: Duration(milliseconds: 200),
    showItemDuration: Duration(milliseconds: 400),
  );
}
