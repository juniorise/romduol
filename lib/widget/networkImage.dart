import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:cached_network_image/cached_network_image.dart';

class NetworkImageLoader extends StatelessWidget {
  final String imagelocation;
  final Function onPressed;
  final double width;
  final double height;
  const NetworkImageLoader(
      {Key key,
      @required this.imagelocation,
      @required this.onPressed,
      this.width = 110,
      this.height = 60})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      color: Palette.bg,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: imagelocation,
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => FlatButton(
          height: height,
          minWidth: width,
          color: Palette.bg,
          onPressed: onPressed,
          child: Icon(Icons.error, color: Palette.red),
        ),
        progressIndicatorBuilder: (context, url, progress) {
          return Container(
            width: width,
            height: height,
            color: Palette.bg,
            alignment: Alignment.center,
            child: Container(
              width: 15,
              height: 15,
              child: CircularProgressIndicator(
                strokeWidth: 3.0,
                value: progress.downloaded != null && progress.totalSize != null
                    ? (progress.downloaded / progress.totalSize).toDouble()
                    : null,
              ),
            ),
          );
        },
      ),
    );
  }
}
