import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/booking/b_accomodation.dart';
import 'package:romduol/screens/booking/b_bike.dart';
import 'package:romduol/screens/booking/b_boat.dart';
import 'package:romduol/screens/booking/b_resturant.dart';
import 'package:romduol/screens/province/comment_page.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/price_with_indicator.dart';
import 'package:romduol/widget/sliver_card_delegate.dart';
import 'package:romduol/widget/star_rating.dart';
import 'package:romduol/widget/theme/theme.dart';

List<CommentModel> comments = [
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
  CommentModel(
    name: "Sok Chan",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    profileimg: "assets/home/profile.png",
    rating: 4,
    useful: 100,
    useless: 2,
  ),
];

///
///NOTED:
///THIS PAGE START HERE
///
///
class DetailTemplate extends StatefulWidget {
  const DetailTemplate({Key key, this.data, @required this.isKH})
      : super(key: key);
  final CardModel data;
  final bool isKH;
  @override
  _DetailTemplateState createState() => _DetailTemplateState();
}

class _DetailTemplateState extends State<DetailTemplate> {
  int currentImage = 0;
  PageController _imageController = PageController(initialPage: 0);
  bool scrollEnabled = true;
  final bool isHasPrice = false;
  bool isZoom = false;

  bool isVisible = false;
  double rate = 0;

  double rateTOTAL = 10;

  @override
  void dispose() {
    super.dispose();
    _imageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.bg,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            titleSpacing: 0.0,
            toolbarHeight: 48,
            elevation: 1,
            expandedHeight: 150 + 48.0,
            forceElevated: true,
            backgroundColor: Palette.sky,
            pinned: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              widget.isKH ? "អំពីរទីកន្លែង" : "About place",
              style: TextStyle(
                color: Colors.white,
                fontFamily: widget.isKH ? 'Kantumruy' : 'Open Sans',
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.text_fields),
                onPressed: () {
                  setState(() {
                    isZoom = !isZoom;
                  });
                },
              )
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: width,
                height: 150 + 48.0,
                child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .doc(widget.data.refpath)
                      .collection("images")
                      .snapshots(),
                  builder: (context, snapshot) {
                    List<String> images = List();
                    if (!snapshot.hasData)
                      return noData();
                    else if (snapshot.hasData) {
                      snapshot.data.docs.forEach((element) {
                        try {
                          images.add(element['image']);
                        } catch (e) {
                          print(e);
                        }
                      });
                      return Stack(
                        children: [
                          ImageViewer(
                            thumnail: widget.data.thumbnail,
                            pageController: _imageController,
                            imageList: images,
                            width: width,
                            currentImage: currentImage,
                            onPageChanged: (index) => setState(
                              () => currentImage = index,
                            ),
                          ), // flutter clean && git add . && git commit -m "added function to convert from english number to khmer number." && git push origin master
                          TextWithIndicator(
                            currentImage: currentImage,
                            imageList: images,
                            pricefrom: widget.data.pricefrom,
                            pricetotal: widget.data.pricetotal,
                            isKH: widget.isKH,
                          ),
                        ],
                      );
                    }
                    return noData();
                  },
                ),
              ),
            ),
          ),
          SliverPersistentHeader(
            floating: true,
            delegate: SliverCardDelegate(
              child: DetailProfile(
                title: widget.data.title,
                width: width,
                location: widget.data.location,
                onBookPressed: () {
                  Widget screen;
                  print(widget.data.refpath);
                  if (widget.data.refpath.contains('accomodations'))
                    screen = BookingAccomodation(isKH: widget.isKH);
                  if (widget.data.refpath
                      .contains('activities/default_data/act_biking'))
                    screen = BookingBike(isKH: widget.isKH);
                  if (widget.data.refpath.contains('restaurants/'))
                    screen = BookingRestaurant(isKH: widget.isKH);

                  if (widget.data.refpath
                      .contains('activities/default_data/act_boating'))
                    screen = BookingBoat(isKH: widget.isKH);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => screen,
                    ),
                  );
                },
                rate: widget.data.rating,
                ratetotal: widget.data.ratetotal,
                isBookAble: widget.data.pricefrom != null ||
                        widget.data.pricetotal != null
                    ? true
                    : false,
                maplocation: widget.data.maplocation,
                isKH: widget.isKH,
              ),
              height: widget.data.ratetotal == null
                  ? 20.0 + 20 + 14 + 16 + 15 + 48 + 17 - 10
                  : 20.0 + 20 + 14 + 16 + 15 + 48 + 17 - 10 + 25,
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Palette.bg,
                  width: width,
                  constraints: BoxConstraints(minHeight: height - 75),
                  child: Column(
                    children: [
                      Column(
                        children: [
                          SizedBox(height: 10),
                          Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 20),
                            decoration: buildBoxDecoration(),
                            child: ArticleDetail(
                              widget: widget,
                              width: width,
                              isZoom: isZoom,
                            ),
                          ),
                          widget.data.refpath
                                  .contains('restaurants/default_data/')
                              ? FoodMenuDetail(
                                  path: widget.data.refpath,
                                  isKH: widget.isKH,
                                )
                              : SizedBox(),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: width,
                        constraints: BoxConstraints(minHeight: 201.0),
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: buildBoxDecoration(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              "បញ្ចេញមតិយោបល់",
                              style: TextStyle(
                                fontFamily:
                                    widget.isKH ? 'Kantumruy' : 'Open Sans',
                              ),
                            ),
                            SizedBox(height: 5),
                            StarRating(
                              size: 30,
                              rating: rate,
                              onRatingChanged: (double _rate) {
                                setState(() => rate = _rate);
                              },
                            ),
                            SizedBox(height: 15),
                            TextField(
                              maxLines: null,
                              style: TextStyle(fontSize: 13),
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 5),
                                border: OutlineInputBorder(
                                    borderRadius: const BorderRadius.all(
                                      const Radius.circular(5.0),
                                    ),
                                    borderSide: BorderSide.none),
                                hintText: "មតិយោបល់",
                                fillColor: Palette.bggrey.withOpacity(0.3),
                                filled: true,
                              ),
                            ),
                            SizedBox(height: 10),
                            FlatButton(
                              onPressed: () {},
                              color: Palette.sky,
                              child: Text(
                                "បង្ហោះជាសាធារណះ",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      FlatButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentPage(
                                comments: comments,
                                isKH: widget.isKH,
                              ),
                            ),
                          );
                        },
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "មតិយោបល់ (${khNum(comments.length.toString(), widget.isKH)})",
                          style: TextStyle(color: Palette.sky),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class FoodMenuDetail extends StatelessWidget {
  const FoodMenuDetail({Key key, this.path, @required this.isKH})
      : super(key: key);

  final bool isKH;
  final String path;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      width: width,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: buildBoxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'បញ្ចី',
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .doc(path)
                .collection('foodmenu')
                .snapshots(),
            builder: (context, snapshot) {
              List<FoodMenu> foods = List();
              if (snapshot.hasData) {
                snapshot.data.docs.forEach(
                  (element) {
                    foods.add(
                      FoodMenu(
                        title: element['title'],
                        thumbnail: element['thumbnail'],
                        price: element['price'].toString(),
                      ),
                    );
                  },
                );

                return Container(
                  height: foods.length * 190.0 / 2 + foods.length * 20 / 2,
                  child: GridView.count(
                    padding: EdgeInsets.zero,
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    childAspectRatio: 3 / 4,
                    mainAxisSpacing: 5,
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      for (int i = 0; i < foods.length; i++)
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: Container(
                            width: width / 2,
                            padding: EdgeInsets.zero,
                            margin: EdgeInsets.zero,
                            decoration: buildBoxDecoration().copyWith(
                              color: Palette.bg,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 5.0,
                                  spreadRadius: 0,
                                  offset: Offset(0, 0),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  width: width / 2,
                                  height: 105,
                                  child: NetworkImageLoader(
                                    imagelocation: foods[i].thumbnail,
                                    onPressed: () {},
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 10,
                                    vertical: 10,
                                  ),
                                  child: Column(
                                    children: [
                                      Text(
                                        foods[i].title,
                                        style: TextStyle(
                                          fontSize: 13,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        khNum(foods[i].price.toString(), isKH) +
                                            "\$",
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Palette.sky,
                                        ),
                                        textAlign: TextAlign.center,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                    ],
                  ),
                );
              }
              return loading();
            },
          ),
        ],
      ),
    );
  }
}

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({
    Key key,
    @required this.widget,
    @required this.width,
    @required this.isZoom,
  }) : super(key: key);

  final bool isZoom;
  final DetailTemplate widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .doc(widget.data.refpath)
          .collection("articles")
          .orderBy('index')
          .snapshots(),
      builder: (context, snapshot) {
        List<ArticleModal> article = List();
        if (snapshot.hasData) {
          snapshot.data.docs.forEach((element) {
            try {
              article.add(ArticleModal(
                header: element.data()['header'] ?? null,
                paragraph: element['paragraph'] ?? null,
              ));
            } catch (e) {
              article.add(ArticleModal(
                paragraph: element['paragraph'] ?? null,
              ));
            }
          });

          return Container(
            width: width,
            child: Wrap(
              children: [
                for (int i = 0; i < article.length; i++)
                  buildArticle(article[i].paragraph),
              ],
            ),
          );
        } else if (snapshot.hasError) return noData();
        return loading();
      },
    );
  }

  Column buildArticle(String article) {
    return Column(
      children: [
        Text(
          khNum(article, widget.isKH),
          style: TextStyle(
            fontSize: isZoom ? 15 : 13,
            color: Palette.text,
            height: isZoom ? 2.2 : 2.1,
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
