import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/booking/b_package.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/price_with_indicator.dart';
import 'package:romduol/widget/sliver_card_delegate.dart';
import 'package:romduol/widget/theme/theme.dart';

class PackageDetail extends StatefulWidget {
  const PackageDetail({Key key, @required this.package, @required this.isKH})
      : super(key: key);

  final PackageModel package;
  final bool isKH;
  @override
  _PackageDetailState createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  int currentImage = 0;
  PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    print(widget.package.maplocation.latitude +
        widget.package.buslocation.latitude);
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Theme(
      data: ThemeData(fontFamily: widget.isKH ? "Kantumruy" : "Open Sans"),
      child: Scaffold(
        backgroundColor: Palette.bg,
        body: CustomScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverAppBar(
              titleSpacing: 0.0,
              toolbarHeight: 48,
              elevation: 1.0,
              forceElevated: true,
              expandedHeight: 150 + 48.0,
              backgroundColor: Palette.sky,
              pinned: true,
              iconTheme: IconThemeData(color: Colors.white),
              title: Text(
                "ដំណើរកំសាន្ត",
                style: TextStyle(color: Colors.white, fontSize: 14),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  width: width,
                  height: 150 + 48.0,
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .doc(widget.package.refpath)
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
                              thumnail: widget.package.thumbnail,
                              pageController: _pageController,
                              imageList: images,
                              width: width,
                              currentImage: currentImage,
                              onPageChanged: (index) => setState(
                                () => currentImage = index,
                              ),
                            ),
                            TextWithIndicator(
                              currentImage: currentImage,
                              imageList: images,
                              text: widget.package.date,
                              isKH: widget.isKH,
                            ),
                          ],
                        );
                      } else
                        return loading();
                    },
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              floating: true,
              delegate: SliverCardDelegate(
                child: DetailProfile(
                  title: widget.package.title,
                  width: width,
                  pricefrom: 25,
                  location: widget.package.location,
                  onBookPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookingPackage(
                        isKH: widget.isKH,
                      ),
                    ),
                  ),
                  maplocation: widget.package.maplocation,
                  buslocation: widget.package.buslocation,
                  isBookAble: true,
                  isKH: widget.isKH,
                ),
                height: 20.0 + 20 + 14 + 16 + 15 + 48 + 17,
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: buildBoxDecoration(),
                              child: StreamBuilder<QuerySnapshot>(
                                stream: FirebaseFirestore.instance
                                    .doc(widget.package.refpath)
                                    .collection("article")
                                    .orderBy('index')
                                    .snapshots(),
                                builder: (context, snapshot) {
                                  List<ArticleModal> article = List();
                                  if (snapshot.hasData) {
                                    snapshot.data.docs.forEach((element) {
                                      try {
                                        article.add(ArticleModal(
                                          header:
                                              element.data()['header'] ?? null,
                                          paragraph:
                                              element['paragraph'] ?? null,
                                        ));
                                      } catch (e) {
                                        article.add(ArticleModal(
                                          paragraph:
                                              element['paragraph'] ?? null,
                                        ));
                                      }
                                    });

                                    return Container(
                                      width: width,
                                      child: Wrap(
                                        children: [
                                          for (int i = 0;
                                              i < article.length;
                                              i++)
                                            buildArticle(article, i),
                                        ],
                                      ),
                                    );
                                  } else if (snapshot.hasError) return noData();

                                  return loading();
                                },
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
                              decoration: buildBoxDecoration(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "សំណួរគេសួរញឹកញាប់ | FAQ",
                                        style: TextStyle(
                                          fontSize: widget.isKH ? 14 : 16,
                                          color: Palette.sky,
                                        ),
                                      ),
                                      Divider()
                                    ],
                                  ),
                                  StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .doc(widget.package.refpath)
                                        .collection('faq')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      List<ArticleModal> faq = [];
                                      if (snapshot.hasData) {
                                        snapshot.data.docs.forEach((element) {
                                          try {
                                            faq.add(
                                              ArticleModal(
                                                question: element['questions'],
                                                paragraph: element['answer'],
                                              ),
                                            );
                                          } catch (e) {
                                            print(e);
                                          }
                                        });
                                        return Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            for (int i = 0; i < faq.length; i++)
                                              buildFAQ(i, faq),
                                          ],
                                        );
                                      } else if (snapshot.hasError)
                                        return noData();

                                      return loading();
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              "Term of Service | Privacy",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Palette.text,
                                fontSize: 12,
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Column buildFAQ(int i, List<ArticleModal> faq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          khNum((i + 1).toString() + ". " + faq[i].question, widget.isKH),
          style: TextStyle(
            fontSize: widget.isKH ? 13 : 16,
            color: Palette.bgdark.withOpacity(0.8),
          ),
        ),
        Text(
          khNum(faq[i].paragraph, widget.isKH),
          style: TextStyle(
            fontSize: widget.isKH ? 13 : 15,
            color: Palette.text,
            height: 2.1,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Column buildArticle(List<ArticleModal> article, int i) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        article[i].header != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    khNum(article[i].header, widget.isKH),
                    style: TextStyle(
                      fontSize: widget.isKH ? 13 : 16,
                      color: Palette.sky,
                    ),
                  ),
                  Divider()
                ],
              )
            : SizedBox(),
        Text(
          khNum(article[i].paragraph, widget.isKH),
          style: TextStyle(
            fontSize: widget.isKH ? 13 : 15,
            color: Palette.text,
            height: 2.1,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
