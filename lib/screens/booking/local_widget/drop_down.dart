import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/theme/theme.dart';

class DropdownCard extends StatelessWidget {
  const DropdownCard({
    Key key,
    @required this.width,
    @required this.onTab,
    @required this.value,
    @required this.total,
    this.endTitle = "បន្ទប់",
    @required this.isKH,
  }) : super(key: key);

  final double width;
  final Function onTab;
  final int value;
  final int total;
  final bool isKH;
  final String endTitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: width,
      decoration:
          buildBoxDecoration().copyWith(borderRadius: BorderRadius.circular(5)),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 20,
            child: Text(
              "ចំនួន ${khNum(value.toString(), isKH)} $endTitle",
              style: TextStyle(color: Palette.bgdark, fontSize: 13),
            ),
          ),
          Positioned.fill(
            top: -1,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Palette.sky,
              ),
              child: DropdownButton(
                onChanged: (e) => onTab(e),
                isExpanded: true,
                icon: Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: Icon(Icons.arrow_drop_down),
                ),
                underline: Container(),
                items: [
                  for (int i = 0; i < total; i++)
                    DropdownMenuItem(
                      value: i,
                      onTap: () => onTab(i),
                      child: Text(
                        '${khNum(i.toString(), isKH)}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 13,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
