import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/auth/login.dart';
import 'package:romduol/screens/booking/b_accomodation.dart';
import 'package:romduol/screens/booking/b_bike.dart';
import 'package:romduol/screens/booking/b_boat.dart';
import 'package:romduol/screens/booking/b_resturant.dart';
import 'package:romduol/screens/province/comment_page.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/user_data.dart';
import 'package:romduol/services/write_data.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/networkImage.dart';
import 'package:romduol/widget/price_with_indicator.dart';
import 'package:romduol/widget/sliver_card_delegate.dart';
import 'package:romduol/widget/star_rating.dart';
import 'package:romduol/widget/theme.dart';

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
  ScrollController scrollController = ScrollController();
  TextEditingController _recommenedController = TextEditingController();

  bool isVisible = false, validate = true, loading = false, _isVisible = true;

  String error = "";
  double rate = 0;

  double rateTOTAL = 10;
  dynamic result;

  @override
  void initState() {
    scrollController.addListener(() {
      if (scrollController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        if (_isVisible) setState(() => _isVisible = false);
      } else if (scrollController.position.userScrollDirection ==
          ScrollDirection.forward) {
        if (!_isVisible &&
            scrollController.offset <
                scrollController.position.maxScrollExtent - 40 - 10 - 200 - 10)
          setState(() => _isVisible = true);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
    _recommenedController.dispose();
    _imageController.dispose();
  }

  void writeRecommendToFirebase({
    String text,
    double rate,
    UserData userData,
  }) async {
    if (userData != null) {
      FirebaseFirestore.instance
          .doc(widget.data.refpath)
          .snapshots()
          .forEach((element) {
        List<String> uids = List();
        if (element.data()['comments'] != null) {
          element.data()['comments'].forEach((element) {
            uids.add(element['uid']);
          });
        }

        if (!uids.contains(userData.uid)) {
          try {
            result = WriteData().uploadRecommend(
              text: text,
              rate: rate,
              ref: widget.data.refpath,
              uid: userData.uid,
            );
            if (result != null) setState(() => loading = false);
          } catch (e) {
            error = e.toString();
            validate = false;
            setState(() => loading = false);
          }
        } else {
          error = "You have recommended!";
          validate = false;
          setState(() => loading = false);
        }
      });
    } else {
      error = "Please sign in first!";
      validate = false;
      setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return StreamBuilder<UserData>(
        stream: UserDatabase(uid: user.uid).userData,
        builder: (context, snapshot) {
          UserData userData;
          if (snapshot.hasData) {
            userData = snapshot.data;
          }
          return Scaffold(
            backgroundColor: Palette.bg,
            body: CustomScrollView(
              controller: scrollController,
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
                    style: TextStyle(color: Colors.white, fontSize: 14),
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
                      child: Stack(
                        children: [
                          ImageViewer(
                            thumnail: widget.data.thumbnail,
                            pageController: _imageController,
                            imageList: widget.data.images ?? [''],
                            width: width,
                            currentImage: currentImage,
                            onPageChanged: (index) => setState(
                              () => currentImage = index,
                            ),
                            id: widget.data.id,
                          ),
                          TextWithIndicator(
                            currentImage: currentImage,
                            imageList: widget.data.images ?? [''],
                            pricefrom: widget.data.pricefrom,
                            pricetotal: widget.data.pricetotal,
                            isKH: widget.isKH,
                          ),
                        ],
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
                      ratingaverage: widget.data.ratingaverage,
                      ratetotal: widget.data.ratetotal,
                      isBookAble: widget.data.pricefrom != null &&
                          widget.data.pricefrom > 0 &&
                          widget.data.pricetotal > 0,
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
                        constraints: BoxConstraints(minHeight: 0),
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
                                    articles: widget.data.articles,
                                  ),
                                ),
                                widget.data.refpath
                                        .contains('restaurants/default_data/')
                                    ? FoodMenuDetail(
                                        foods: widget.data.foodmenu,
                                        isKH: widget.isKH,
                                      )
                                    : SizedBox(),
                              ],
                            ),
                            SizedBox(height: 10),
                            Container(
                              decoration: buildBoxDecoration(),
                              width: width,
                              constraints: BoxConstraints(minHeight: 200.0),
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.isKH
                                        ? "បញ្ចេញមតិយោបល់"
                                        : "Recommend",
                                    style: TextStyle(fontFamily: 'Kantumruy'),
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
                                    controller: _recommenedController,
                                    style: TextStyle(fontSize: 13),
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.symmetric(
                                        horizontal: 10.0,
                                        vertical: 5,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: const BorderRadius.all(
                                          const Radius.circular(5.0),
                                        ),
                                        borderSide: BorderSide.none,
                                      ),
                                      hintText: widget.isKH
                                          ? "មតិយោបល់"
                                          : "Write your recommendation...",
                                      fillColor:
                                          Palette.bggrey.withOpacity(0.3),
                                      filled: true,
                                    ),
                                  ),
                                  SizedBox(height: error.isNotEmpty ? 5.0 : 0),
                                  error.isNotEmpty
                                      ? Row(
                                          children: [
                                            SizedBox(
                                              width: 5.0,
                                            ),
                                            Text(
                                              error,
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: Palette.red,
                                              ),
                                            ),
                                            SizedBox(width: 5.0),
                                            userData == null &&
                                                    error ==
                                                        "Please sign in first!"
                                                ? InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              LoginScreen(
                                                            isKH: widget.isKH,
                                                          ),
                                                        ),
                                                      );
                                                    },
                                                    child: Text(
                                                      "Sign in",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Palette.sky,
                                                      ),
                                                    ),
                                                  )
                                                : SizedBox()
                                          ],
                                        )
                                      : SizedBox(),
                                  SizedBox(height: 10),
                                  AnimatedContainer(
                                    width: 160,
                                    duration: Duration(milliseconds: 100),
                                    child: FlatButton(
                                      onPressed: () {
                                        if (_recommenedController
                                            .text.isEmpty) {
                                          setState(() {
                                            error = "Empty string";
                                            validate = false;
                                          });
                                        } else if (rate == 0) {
                                          setState(() {
                                            error = "Rate can't be zero";
                                            validate = false;
                                          });
                                        } else {
                                          setState(() => loading = true);
                                          writeRecommendToFirebase(
                                            text: _recommenedController.text,
                                            rate: rate,
                                            userData: userData,
                                          );
                                        }
                                      },
                                      color: Palette.sky,
                                      splashColor: Colors.transparent,
                                      child: !loading
                                          ? Text(
                                              widget.isKH
                                                  ? result == null
                                                      ? "បង្ហោះជាសាធារណះ"
                                                      : "បានបង្ហោះ"
                                                  : result == null
                                                      ? "Publish"
                                                      : "Publised",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: 13,
                                              ),
                                            )
                                          : Center(
                                              heightFactor: 1,
                                              child: Container(
                                                width: 10,
                                                height: 10,
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                  valueColor:
                                                      AlwaysStoppedAnimation<
                                                          Color>(Colors.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            showCommentsButton(context, !_isVisible),
                          ],
                        ),
                      ),
                      
                    ],
                  ),
                )
              ],
            ),
            bottomNavigationBar: Builder(builder: (context) {
              return showCommentsButton(context, _isVisible);
            }),
          );
        });
  }

  AnimatedContainer showCommentsButton(BuildContext context, bool isVisible) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      height: isVisible ? 48.0 : 0.0,
      padding: EdgeInsets.only(top: isVisible ? 0.0 : 18.0,),
      width: MediaQuery.of(context).size.width,
      decoration: buildBoxDecoration(),
      child: FlatButton(
        onPressed: () {
          scrollController.animateTo(100,
              duration: Duration(milliseconds: 100), curve: Curves.bounceIn);
          final snackBar = SnackBar(
            content: Text('No comments'),
            backgroundColor: Palette.sky,
          );
          if (widget.data.comments != null) {
            if (widget.data.comments.length > 0) {
              showModalBottomSheet(
                context: context,
                builder: (context) => Center(
                  child: Container(
                    decoration:
                        buildBoxDecoration().copyWith(color: Palette.bg),
                    child: CommentPage(
                      comments: widget.data.comments,
                      isKH: widget.isKH,
                    ),
                  ),
                ),
              );
            }
          } else
            Scaffold.of(context).showSnackBar(snackBar);
        },
        child: Text(
          widget.isKH
              ? "មតិយោបល់ (${khNum(widget.data.comments != null ? widget.data.comments.length.toString() : 0.toString(), widget.isKH)})"
              : "Comments (${khNum(widget.data.comments != null ? widget.data.comments.length.toString() : 0.toString(), widget.isKH)})",
          style: TextStyle(color: Palette.sky),
          textAlign: TextAlign.left,
        ),
      ),
    );
  }
}

class FoodMenuDetail extends StatelessWidget {
  const FoodMenuDetail({Key key, this.foods, @required this.isKH})
      : super(key: key);

  final bool isKH;
  final List<FoodMenu> foods;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return foods != null && foods.length > 0
        ? Container(
            width: width,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: buildBoxDecoration(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isKH ? 'បញ្ចី' : "Menu",
                  style: TextStyle(fontSize: 14),
                ),
                SizedBox(height: 10),
                Container(
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
                )
              ],
            ),
          )
        : SizedBox();
  }
}

class ArticleDetail extends StatelessWidget {
  const ArticleDetail({
    Key key,
    @required this.widget,
    @required this.width,
    @required this.isZoom,
    @required this.articles,
  }) : super(key: key);

  final bool isZoom;
  final List<dynamic> articles;
  final DetailTemplate widget;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      child: articles != null
          ? Wrap(
              children: [
                for (int i = 0; i < articles.length; i++)
                  buildArticle(articles[i]),
              ],
            )
          : SizedBox(),
    );
  }

  Column buildArticle(String article) {
    return Column(children: [
      Text(
        khNum(article, widget.isKH),
        style: TextStyle(
          fontSize: isZoom
              ? widget.isKH
                  ? 15
                  : 17
              : widget.isKH
                  ? 13
                  : 15,
          color: Palette.text,
          height: isZoom ? 2.2 : 2.1,
        ),
      ),
      SizedBox(height: 20),
    ]);
  }
}
