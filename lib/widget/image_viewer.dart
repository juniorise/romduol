import 'package:flutter/material.dart';
import 'package:romduol/widget/networkImage.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key key,
    @required this.pageController,
    @required this.imageList,
    @required this.width,
    @required this.currentImage,
    this.thumnail,
    this.onPageChanged,
  }) : super(key: key);

  final PageController pageController;
  final List<String> imageList;
  final String thumnail;
  final double width;
  final int currentImage;
  final Function onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      allowImplicitScrolling: true,
      onPageChanged: onPageChanged,
      children: [
        buildImage(
          index: 0,
          child: Hero(
            tag: "thumnail" + thumnail,
            child: NetworkImageLoader(
              imagelocation: thumnail,
              onPressed: () {},
            ),
          ),
        ),
        for (int index = 1; index < imageList.length + 1; index++)
          buildImage(
            index: index - 1,
            child: NetworkImageLoader(
              imagelocation: imageList[index - 1],
              onPressed: () {},
            ),
          )
      ],
    );
  }

  Container buildImage({int index, Widget child}) {
    return Container(
      width: width,
      height: 150 + 48.0,
      child: Stack(
        children: [
          Positioned.fill(child: child),
          Positioned.fill(
            child: FlatButton(
              highlightColor: Colors.white.withOpacity(0.2),
              splashColor: Colors.black.withOpacity(0.2),
              onPressed: () {
                if (index == imageList.length - 1) {
                  pageController.animateToPage(
                    0,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                } else {
                  pageController.animateToPage(
                    index + 1,
                    duration: Duration(milliseconds: 200),
                    curve: Curves.ease,
                  );
                }
              },
              child: Container(),
            ),
          )
        ],
      ),
    );
  }
}
