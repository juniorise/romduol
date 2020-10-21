import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/widget/star_rating.dart';

class CommentPage extends StatelessWidget {
  const CommentPage({Key key, @required this.comments}) : super(key: key);

  final List<CommentModel> comments;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: buildAppBar(context, "មតិយោបល់"),
      body: ListView(
        children: [
          for (int index = 0; index < comments.length; index++)
            buildComment(width, index),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Container buildComment(double width, int index) {
    return Container(
      width: width,
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      margin: EdgeInsets.only(bottom: 10, top: index == 0 ? 10 : 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Palette.sky),
                  borderRadius: BorderRadius.circular(35),
                ),
                padding: EdgeInsets.all(1),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(35),
                  child: Image.asset(
                    comments[index].profileimg,
                    width: 35,
                    height: 35,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(width: 10.0),
              Container(
                decoration: buildBoxDecoration(),
                padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                width: width - 35 - 10 - 20 - 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          comments[index].name,
                          textAlign: TextAlign.start,
                        ),
                        StarRating(rating: comments[index].rating.toDouble())
                      ],
                    ),
                    Text(
                      "1 month ago",
                      style: TextStyle(fontSize: 11),
                    ),
                    SizedBox(height: 5),
                    Text(comments[index].comment),
                    SizedBox(height: 5),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          Container(
            height: 20,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.thumb_up,
                      color: Palette.sky,
                      size: 16,
                    ),
                    label: Text(
                      "មានប្រយោជន៍",
                      style: TextStyle(
                        color: Palette.text,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(
                      Icons.thumb_down_outlined,
                      color: Palette.red,
                      size: 16,
                    ),
                    label: Text(
                      "មិនផ្តល់ប្រយោជន៍",
                      style: TextStyle(
                        color: Palette.text,
                        fontSize: 12,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  BoxDecoration buildBoxDecoration() {
    return BoxDecoration(
      boxShadow: [
        BoxShadow(
          color: Colors.black87.withOpacity(0.1),
          blurRadius: 1.0,
          offset: Offset(0, 0),
        )
      ],
      color: Colors.white,
    );
  }

  PreferredSize buildAppBar(BuildContext context, String title) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: AppBar(
        elevation: 0.5,
        backgroundColor: Palette.sky,
        titleSpacing: 0.0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          title,
          textAlign: TextAlign.start,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
