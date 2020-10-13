import 'package:flutter/material.dart';

class ImageViewer extends StatelessWidget {
  const ImageViewer({
    Key key,
    @required this.pageController,
    @required this.imageList,
    @required this.width,
    @required this.currentImage,
    this.onPageChanged,
  }) : super(key: key);

  final PageController pageController;
  final List<String> imageList;
  final double width;
  final int currentImage;
  final Function onPageChanged;

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      controller: pageController,
      itemCount: imageList.length,
      allowImplicitScrolling: true,
      itemBuilder: (context, index) {
        return Container(
          width: width,
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  imageList[index],
                  fit: BoxFit.cover,
                ),
              ),
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
      },
      onPageChanged: onPageChanged,
    );
  }
}
