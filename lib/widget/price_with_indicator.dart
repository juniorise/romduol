import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/theme/theme.dart';

class TextWithIndicator extends StatelessWidget {
  const TextWithIndicator({
    Key key,
    @required this.imageList,
    @required this.currentImage,
    this.text,
    this.pricefrom,
    this.pricetotal,
  }) : super(key: key);

  final List<String> imageList;
  final int currentImage;
  final String text;
  final double pricefrom, pricetotal;

  @override
  Widget build(BuildContext context) {
    String price;
    if (pricetotal != null && pricefrom != null) {
      price = pricetotal != null && pricefrom != null
          ? "ចាប់ពី ${khNum(pricefrom.toString())}\$ - ${khNum(pricetotal.toString())}\$"
          : pricetotal != null && pricefrom == null
              ? "ចាប់ពី ${khNum(pricefrom.toString())}\$"
              : "${khNum(pricetotal.toString())}\$";
    }
    return Positioned(
      right: 20,
      left: 0,
      bottom: 20,
      child: IgnorePointer(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            text != null
                ? Container(
                    height: 36,
                    alignment: Alignment.center,
                    color: Palette.sky.withOpacity(0.8),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                    child: Text(
                      khNum(text),
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  )
                : pricefrom != null || pricetotal != null
                    ? Container(
                        height: 36,
                        alignment: Alignment.center,
                        color: Palette.sky.withOpacity(0.8),
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 3),
                        child: Text(
                          price,
                          style: TextStyle(fontSize: 12, color: Colors.white),
                        ),
                      )
                    : SizedBox(),
            Container(
              width: (10.0 + 5) * (imageList.length + 1),
              height: 10,
              alignment: Alignment.centerRight,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: imageList.length + 1,
                itemBuilder: (context, index) {
                  return Container(
                    width: 10,
                    height: 10,
                    margin: EdgeInsets.only(right: 5),
                    alignment: Alignment.center,
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      width: currentImage == index ? 10 : 8,
                      height: currentImage == index ? 10 : 8,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color:
                            currentImage == index ? Palette.sky : Colors.white,
                        border: Border.all(
                          color: Colors.white,
                          width: 1.5,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
