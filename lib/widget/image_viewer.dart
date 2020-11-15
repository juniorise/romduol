import 'package:flutter/material.dart';
import 'package:romduol/widget/networkImage.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key key,
    @required this.pageController,
    @required this.imageList,
    @required this.width,
    @required this.currentImage,
    @required this.id,
    this.thumnail,
    this.onPageChanged,
    @required this.index,
  }) : super(key: key);

  final PageController pageController;
  final List<dynamic> imageList;
  final String thumnail, id;
  final double width;
  final int currentImage, index;
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
            tag: id != null
                ? id + index.toString()
                : thumnail + index.toString(),
            child: NetworkImageLoader(
              imagelocation: thumnail,
              onPressed: () {},
            ),
          ),
        ),
        for (int index = 1; index < imageList.length + 1; index++)
          buildImage(
            index: index,
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
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              onPressed: () {
                if (index == imageList.length) {
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
