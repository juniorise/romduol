import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/comment_page.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/price_with_indicator.dart';
import 'package:romduol/widget/sliver_card_delegate.dart';
import 'package:romduol/widget/star_rating.dart';

List<String> imageList = [
  "assets/provinces/sihanouk.png",
  "assets/provinces/kep.png",
  "assets/provinces/kohkong.png"
];

final List<String> articleList = [
  "ឧទ្យានជាតិព្រះមុនីវង្សភ្នំបូកគោឬឧទ្យានជាតិភ្នំបូកគោមានទីតាំងស្ថិតនៅក្នុងស្រុកទឹកឈូខេត្តកំពត។ ភ្នំបូកគោមានកម្ពស់ ១០៧៥ម៉ែត្រធៀបទៅនឹងនីវ៉ូទឹកសមុទ្រនិងមានចម្ងាយប្រមាណ ១១គីឡូម៉ែត្រពីក្រុងកំពតទៅកាន់ជើងភ្នំនិងចម្ងាយ ៣២គីឡូម៉ែត្រពីជើងភ្នំដល់កំពូលភ្នំ។ ភ្នំបូកគោត្រូវបានរកឃើញនៅឆ្នាំ១៩១៧ ដោយជនជាតិបារាំងនិងត្រូវបានអភិវឌ្ឍឲ្យទៅជារមណីយដ្ឋាននៅឆ្នាំ១៩២១ ក្នុងរជ្ជកាលព្រះបាទស៊ីសុវត្ថិ។",
  "នៅអំឡុងពេលនោះភ្នំបូកគោគឺជាទីកន្លែងកម្សាន្តដ៏ល្បីល្បាញសម្រាប់អភិជនបារាំងនិងរាជវង្សានុវង្ស។ឧទ្យានជាតិភ្នំបូកគោគឺជាឧទ្យានមួយក្នុងចំណោមឧទ្យានជាតិដ៏ស្រស់ស្អាតរបស់ព្រះរាជាណាចក្រកម្ពុជា។ ភ្នំបូកគោល្បីឈ្មោះដោយសារតែអាកាសធាតុត្រជាក់ពេញមួយឆ្នាំនិងសម្រស់ព្រៃព្រឹក្សាធម្មជាតិដ៏ស្រស់បំព្រងល្អឯកគ្មានគូប្រដូចក្នុងតំបន់។ ",
  "ពីលើកំពូលភ្នំភ្ញៀវទេសចរអាចគយគន់ទិដ្ឋភាពដ៏ពិចពិលរមិលមើលនៃទិដ្ឋភាពទីក្រុងកំពត ឆ្នេរសមុទ្រកែប ខេត្តព្រះសីហនុ និងកោះជាច្រើនដែលនៅខាងក្រោម។ ឧទ្យានជាតិភ្នំបូកគោ មានដើមឈើត្រូពិចដុះពាសពេញលើភ្នំ និងសត្វព្រៃជាច្រើនប្រភេទ ព្រមទាំងទឹកជ្រោះតូចធំដ៏ស្រស់ស្អាត ជាពិសេសគឺទឹកជ្រោះពពកវិលដ៏ល្បីល្បាញ។ ភ្នំបូកគោគឺជាទីកម្សាន្តធម្មជាតិដ៏សម្បូរបែបបំផុតមួយក្នុងព្រះរាជាណាចក្រកម្ពុជា មិនថាធម្មជាតិ អាកាសធាតុ ដំណើរកម្សាន្តរុករកឬសម្រាកលម្ហែនោះទេ សុទ្ធសឹងតែអាចធ្វើឲ្យភ្ញៀវទេសចរមានអារម្មណ៍រីករាយស្រស់ថ្លានិងអនុស្សាវរីយ៍បំភ្លេចមិនបាន។",
  "ពីលើកំពូលភ្នំភ្ញៀវទេសចរអាចគយគន់ទិដ្ឋភាពដ៏ពិចពិលរមិលមើលនៃទិដ្ឋភាពទីក្រុងកំពត ឆ្នេរសមុទ្រកែប ខេត្តព្រះសីហនុ និងកោះជាច្រើនដែលនៅខាងក្រោម។ ឧទ្យានជាតិភ្នំបូកគោ មានដើមឈើត្រូពិចដុះពាសពេញលើភ្នំ និងសត្វព្រៃជាច្រើនប្រភេទ ព្រមទាំងទឹកជ្រោះតូចធំដ៏ស្រស់ស្អាត ជាពិសេសគឺទឹកជ្រោះពពកវិលដ៏ល្បីល្បាញ។ ភ្នំបូកគោគឺជាទីកម្សាន្តធម្មជាតិដ៏សម្បូរបែបបំផុតមួយក្នុងព្រះរាជាណាចក្រកម្ពុជា មិនថាធម្មជាតិ អាកាសធាតុ ដំណើរកម្សាន្តរុករកឬសម្រាកលម្ហែនោះទេ សុទ្ធសឹងតែអាចធ្វើឲ្យភ្ញៀវទេសចរមានអារម្មណ៍រីករាយស្រស់ថ្លានិងអនុស្សាវរីយ៍បំភ្លេចមិនបាន។",
  "ពីលើកំពូលភ្នំភ្ញៀវទេសចរអាចគយគន់ទិដ្ឋភាពដ៏ពិចពិលរមិលមើលនៃទិដ្ឋភាពទីក្រុងកំពត ឆ្នេរសមុទ្រកែប ខេត្តព្រះសីហនុ និងកោះជាច្រើនដែលនៅខាងក្រោម។ ឧទ្យានជាតិភ្នំបូកគោ មានដើមឈើត្រូពិចដុះពាសពេញលើភ្នំ និងសត្វព្រៃជាច្រើនប្រភេទ ព្រមទាំងទឹកជ្រោះតូចធំដ៏ស្រស់ស្អាត ជាពិសេសគឺទឹកជ្រោះពពកវិលដ៏ល្បីល្បាញ។ ភ្នំបូកគោគឺជាទីកម្សាន្តធម្មជាតិដ៏សម្បូរបែបបំផុតមួយក្នុងព្រះរាជាណាចក្រកម្ពុជា មិនថាធម្មជាតិ អាកាសធាតុ ដំណើរកម្សាន្តរុករកឬសម្រាកលម្ហែនោះទេ សុទ្ធសឹងតែអាចធ្វើឲ្យភ្ញៀវទេសចរមានអារម្មណ៍រីករាយស្រស់ថ្លានិងអនុស្សាវរីយ៍បំភ្លេចមិនបាន។",
];

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
///
///NOTED:
///THIS PAGE START HERE
///
///
class DetailTemplate extends StatefulWidget {
  const DetailTemplate({Key key}) : super(key: key);

  @override
  _DetailTemplateState createState() => _DetailTemplateState();
}

class _DetailTemplateState extends State<DetailTemplate> {
  int currentImage = 0;
  PageController _imageController = PageController(initialPage: 0);
  ScrollController _scrollController;
  bool scrollEnabled = true;
  final bool isHasPrice = false;

  bool isVisible = false;
  double rate = 0;

  double rateTOTAL = 10;
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController = ScrollController();
    _scrollController
      ..addListener(
        () {
          print(_scrollController.offset);
          if (_scrollController.offset == 0) {
            print("FUNCTI");
          }
        },
      );
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
            title: Text("អំពីរទីកន្លែង", style: TextStyle(color: Colors.white)),
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                width: width,
                height: 150 + 48.0,
                child: Stack(
                  children: [
                    ImageViewer(
                      pageController: _imageController,
                      imageList: imageList,
                      width: width,
                      currentImage: currentImage,
                      onPageChanged: (index) =>
                          setState(() => currentImage = index),
                    ),
                    TextWithIndicator(
                      currentImage: currentImage,
                      imageList: imageList,
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
                title:
                    "ភ្នំបូកគោបោះតង់សរសេរលេងលេងលេងលេងលេលងេលេងលេងលេងលេងេលេងលេង",
                width: width,
                location: "ខេត្តកំពត",
                onBookPressed: () {},
                rate: 3.0,
                ratetotal: rateTOTAL,
                price: 25,
              ),
              height: rateTOTAL == null
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
                      SizedBox(height: 10),
                      Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                        decoration: buildBoxDecoration(),
                        child: Wrap(
                          children: [
                            for (int i = 0; i < articleList.length; i++)
                              Column(
                                children: [
                                  Text(
                                    articleList[i],
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Palette.text,
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                ],
                              ),
                          ],
                        ),
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
                            Text("បញ្ចេញមតិយោបល់"),
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
                              builder: (context) =>
                                  CommentPage(comments: comments),
                            ),
                          );
                        },
                        highlightColor: Colors.white,
                        splashColor: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "មតិយោបល់ (${comments.length})",
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
