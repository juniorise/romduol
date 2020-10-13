import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';

//reference: https://stackoverflow.com/questions/46637566/how-to-create-rating-star-bar-properly
typedef void RatingChangeCallback(double rating);

class StarRating extends StatelessWidget {
  final int starCount;
  final double rating;
  final RatingChangeCallback onRatingChanged;

  StarRating({this.starCount = 5, this.rating = .0, this.onRatingChanged});

  Widget buildStar(BuildContext context, int index) {
    Color color = Palette.yellow;
    Icon icon;
    if (index >= rating) {
      icon = Icon(
        Icons.star_border,
        color: color,
        size: 16,
      );
    } else if (index > rating - 1 && index < rating) {
      icon = Icon(
        Icons.star_half,
        color: color,
        size: 16,
      );
    } else {
      icon = Icon(
        Icons.star,
        color: color,
        size: 16,
      );
    }
    return InkResponse(
      onTap:
          onRatingChanged == null ? null : () => onRatingChanged(index + 1.0),
      child: icon,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
        children:
            List.generate(starCount, (index) => buildStar(context, index)));
  }
}
