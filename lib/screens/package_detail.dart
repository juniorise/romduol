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
                      StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .doc(widget.package.refpath)
                            .collection("article")
                            .orderBy('index')
                            .snapshots(),
                        builder: (context, snapshot) {
                          List<ArticleModal> article = List();
                          ArticleModal faq;
                          if (snapshot.hasData) {
                            snapshot.data.docs.forEach((element) {
                              try {
                                if (element.id == 'faq') {
                                  faq = ArticleModal(
                                    header: element.exists
                                        ? element['header']
                                        : null,
                                    question: element['question'] ?? null,
                                    paragraph: element['paragraph'] ?? null,
                                  );
                                } else {
                                  article.add(ArticleModal(
                                    header: element.exists
                                        ? element['header']
                                        : null,
                                    paragraph: element['paragraph'] ?? null,
                                  ));
                                }
                              } catch (e) {
                                article.add(ArticleModal(
                                  paragraph: element['paragraph'] ?? null,
                                ));
                              }
                            });
                            return Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: buildBoxDecoration(),
                                  child: Wrap(
                                    children: [
                                      for (int i = 0; i < article.length; i++)
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            article[i].header != null
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
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
                                        ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 20),
                                  decoration: buildBoxDecoration(),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            faq.header,
                                            style: TextStyle(
                                              fontSize: 14,
                                              color: Palette.sky,
                                            ),
                                          ),
                                          Divider()
                                        ],
                                      ),
                                      Text(
                                        faq.question,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color:
                                              Palette.bgdark.withOpacity(0.8),
                                        ),
                                      ),
                                      Text(
                                        faq.paragraph,
                                        style: TextStyle(
                                          fontSize: 13,
                                          color: Palette.text,
                                        ),
                                      ),
                                      SizedBox(height: 10),
                                    ],
                                  ),
                                )
                              ],
                            );
                          } else if (snapshot.hasError) {
                            print("NO DATA");
                            return Container(
                              padding: EdgeInsets.symmetric(
                                  vertical: 10, horizontal: 20),
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
                          return Center(
                              heightFactor: 2,
                              child: CircularProgressIndicator());
                        },
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

  final List<String> articleList = [
    "ឧទ្យានជាតិព្រះមុនីវង្សភ្នំបូកគោឬឧទ្យានជាតិភ្នំបូកគោមានទីតាំងស្ថិតនៅក្នុងស្រុកទឹកឈូខេត្តកំពត។ ភ្នំបូកគោមានកម្ពស់ ១០៧៥ម៉ែត្រធៀបទៅនឹងនីវ៉ូទឹកសមុទ្រនិងមានចម្ងាយប្រមាណ ១១គីឡូម៉ែត្រពីក្រុងកំពតទៅកាន់ជើងភ្នំនិងចម្ងាយ ៣២គីឡូម៉ែត្រពីជើងភ្នំដល់កំពូលភ្នំ។ ភ្នំបូកគោត្រូវបានរកឃើញនៅឆ្នាំ១៩១៧ ដោយជនជាតិបារាំងនិងត្រូវបានអភិវឌ្ឍឲ្យទៅជារមណីយដ្ឋាននៅឆ្នាំ១៩២១ ក្នុងរជ្ជកាលព្រះបាទស៊ីសុវត្ថិ។",
    "នៅអំឡុងពេលនោះភ្នំបូកគោគឺជាទីកន្លែងកម្សាន្តដ៏ល្បីល្បាញសម្រាប់អភិជនបារាំងនិងរាជវង្សានុវង្ស។ឧទ្យានជាតិភ្នំបូកគោគឺជាឧទ្យានមួយក្នុងចំណោមឧទ្យានជាតិដ៏ស្រស់ស្អាតរបស់ព្រះរាជាណាចក្រកម្ពុជា។ ភ្នំបូកគោល្បីឈ្មោះដោយសារតែអាកាសធាតុត្រជាក់ពេញមួយឆ្នាំនិងសម្រស់ព្រៃព្រឹក្សាធម្មជាតិដ៏ស្រស់បំព្រងល្អឯកគ្មានគូប្រដូចក្នុងតំបន់។ ",
    "ពីលើកំពូលភ្នំភ្ញៀវទេសចរអាចគយគន់ទិដ្ឋភាពដ៏ពិចពិលរមិលមើលនៃទិដ្ឋភាពទីក្រុងកំពត ឆ្នេរសមុទ្រកែប ខេត្តព្រះសីហនុ និងកោះជាច្រើនដែលនៅខាងក្រោម។ ឧទ្យានជាតិភ្នំបូកគោ មានដើមឈើត្រូពិចដុះពាសពេញលើភ្នំ និងសត្វព្រៃជាច្រើនប្រភេទ ព្រមទាំងទឹកជ្រោះតូចធំដ៏ស្រស់ស្អាត ជាពិសេសគឺទឹកជ្រោះពពកវិលដ៏ល្បីល្បាញ។ ភ្នំបូកគោគឺជាទីកម្សាន្តធម្មជាតិដ៏សម្បូរបែបបំផុតមួយក្នុងព្រះរាជាណាចក្រកម្ពុជា មិនថាធម្មជាតិ អាកាសធាតុ ដំណើរកម្សាន្តរុករកឬសម្រាកលម្ហែនោះទេ សុទ្ធសឹងតែអាចធ្វើឲ្យភ្ញៀវទេសចរមានអារម្មណ៍រីករាយស្រស់ថ្លានិងអនុស្សាវរីយ៍បំភ្លេចមិនបាន។",
    "ពីលើកំពូលភ្នំភ្ញៀវទេសចរអាចគយគន់ទិដ្ឋភាពដ៏ពិចពិលរមិលមើលនៃទិដ្ឋភាពទីក្រុងកំពត ឆ្នេរសមុទ្រកែប ខេត្តព្រះសីហនុ និងកោះជាច្រើនដែលនៅខាងក្រោម។ ឧទ្យានជាតិភ្នំបូកគោ មានដើមឈើត្រូពិចដុះពាសពេញលើភ្នំ និងសត្វព្រៃជាច្រើនប្រភេទ ព្រមទាំងទឹកជ្រោះតូចធំដ៏ស្រស់ស្អាត ជាពិសេសគឺទឹកជ្រោះពពកវិលដ៏ល្បីល្បាញ។ ភ្នំបូកគោគឺជាទីកម្សាន្តធម្មជាតិដ៏សម្បូរបែបបំផុតមួយក្នុងព្រះរាជាណាចក្រកម្ពុជា មិនថាធម្មជាតិ អាកាសធាតុ ដំណើរកម្សាន្តរុករកឬសម្រាកលម្ហែនោះទេ សុទ្ធសឹងតែអាចធ្វើឲ្យភ្ញៀវទេសចរមានអារម្មណ៍រីករាយស្រស់ថ្លានិងអនុស្សាវរីយ៍បំភ្លេចមិនបាន។",
    "ពីលើកំពូលភ្នំភ្ញៀវទេសចរអាចគយគន់ទិដ្ឋភាពដ៏ពិចពិលរមិលមើលនៃទិដ្ឋភាពទីក្រុងកំពត ឆ្នេរសមុទ្រកែប ខេត្តព្រះសីហនុ និងកោះជាច្រើនដែលនៅខាងក្រោម។ ឧទ្យានជាតិភ្នំបូកគោ មានដើមឈើត្រូពិចដុះពាសពេញលើភ្នំ និងសត្វព្រៃជាច្រើនប្រភេទ ព្រមទាំងទឹកជ្រោះតូចធំដ៏ស្រស់ស្អាត ជាពិសេសគឺទឹកជ្រោះពពកវិលដ៏ល្បីល្បាញ។ ភ្នំបូកគោគឺជាទីកម្សាន្តធម្មជាតិដ៏សម្បូរបែបបំផុតមួយក្នុងព្រះរាជាណាចក្រកម្ពុជា មិនថាធម្មជាតិ អាកាសធាតុ ដំណើរកម្សាន្តរុករកឬសម្រាកលម្ហែនោះទេ សុទ្ធសឹងតែអាចធ្វើឲ្យភ្ញៀវទេសចរមានអារម្មណ៍រីករាយស្រស់ថ្លានិងអនុស្សាវរីយ៍បំភ្លេចមិនបាន។",
  ];

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

  Column article(String title, String describe) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 15.0),
        Text(
          title,
          style: TextStyle(fontSize: 14, color: Palette.sky),
        ),
        Divider(),
        Text(
          describe,
          style: TextStyle(fontSize: 13, color: Palette.text),
        ),
      ],
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
