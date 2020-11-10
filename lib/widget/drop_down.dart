import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/theme.dart';

class DropdownCard extends StatelessWidget {
  const DropdownCard({
    Key key,
    @required this.width,
    @required this.onTab,
    @required this.value,
    @required this.total,
    @required this.endTitle,
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
              isKH
                  ? "ចំនួន ${khNum(value.toString(), isKH)} $endTitle"
                  : "For ${khNum(value.toString(), isKH)} $endTitle",
              style: TextStyle(color: Palette.bgdark, fontSize: 13),
            ),
          ),
          Positioned.fill(
            top: -1,
            child: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Palette.sky,
                splashColor: Colors.transparent,
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

class BuildDropdown extends StatelessWidget {
  const BuildDropdown({
    Key key,
    @required this.items,
    @required this.onChanged,
    @required this.val,
    @required this.header,
  }) : super(key: key);

  final List<String> items;
  final Function onChanged;
  final String val, header;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          header,
          style: TextStyle(
            color: Palette.sky,
          ),
        ),
        SizedBox(height: 5.0),
        Container(
          height: 48,
          color: Palette.bggrey.withOpacity(0.2),
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Positioned(
                left: 12,
                child: Text(
                  val,
                  style: TextStyle(color: Palette.bgdark, fontSize: 13),
                ),
              ),
              Positioned.fill(
                top: -1,
                child: Theme(
                  data: Theme.of(context).copyWith(
                    canvasColor: Palette.sky,
                    splashColor: Colors.transparent,
                  ),
                  child: DropdownButton(
                    onChanged: (e) => onChanged(e),
                    isExpanded: true,
                    icon: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Icon(Icons.arrow_drop_down),
                    ),
                    underline: Container(),
                    items: [
                      for (int i = 0; i < items.length; i++)
                        DropdownMenuItem(
                          value: items[i],
                          onTap: () {},
                          child: Text(
                            items[i],
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
        ),
        SizedBox(height: 12.0),
      ],
    );
  }
}
