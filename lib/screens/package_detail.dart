import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/price_with_indicator.dart';
import 'package:romduol/widget/sliver_card_delegate.dart';

class PackageDetail extends StatefulWidget {
  const PackageDetail({Key key, @required this.package}) : super(key: key);

  final PackageModel package;
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
    return Scaffold(
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
            title: Text("ដំណើរកំសាន្ត", style: TextStyle(color: Colors.white)),
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
                    if (!snapshot.hasData) {
                      return Container(
                        child: Center(
                          child: Text("No data found"),
                        ),
                      );
                    } else if (snapshot.hasData) {
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
                          ),
                        ],
                      );
                    } else
                      return Center(child: CircularProgressIndicator());
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
                price: 25,
                location: widget.package.location,
                onBookPressed: () {},
                maplocation: widget.package.maplocation,
                buslocation: widget.package.buslocation,
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
                                          buildArticle(article, i),
                                      ],
                                    ),
                                  );
                                } else if (snapshot.hasError) {
                                  print("NO DATA");
                                  return noData();
                                }
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "សំណួរគេសួរញឹកញាប់ | FAQ",
                                      style: TextStyle(
                                        fontSize: 14,
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
                                    else
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
                              fontFamily: "Open Sans",
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
    );
  }

  Column buildFAQ(int i, List<ArticleModal> faq) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          (i + 1).toString() + ". " + faq[i].question,
          style: TextStyle(
            fontSize: 14,
            color: Palette.bgdark.withOpacity(1),
          ),
        ),
        Text(
          faq[i].paragraph,
          style: TextStyle(
            fontSize: 13,
            color: Palette.text,
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
                    article[i].header,
                    style: TextStyle(
                      fontSize: 14,
                      color: Palette.sky,
                    ),
                  ),
                  Divider()
                ],
              )
            : SizedBox(),
        Text(
          article[i].paragraph,
          style: TextStyle(
            fontSize: 13,
            color: Palette.text,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Center loading() {
    return Center(
      heightFactor: 1,
      child: Container(
        width: 30,
        height: 30,
        child: CircularProgressIndicator(),
      ),
    );
  }

  Container noData() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      decoration: buildBoxDecoration(),
      child: Text(
        "គ្មានទិន្នន័យ",
        style: TextStyle(
          fontSize: 13,
          color: Palette.text,
        ),
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
        elevation: 0.0,
        backgroundColor: Palette.white90,
        titleSpacing: 0.0,
        title: Text(title, textAlign: TextAlign.start),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
