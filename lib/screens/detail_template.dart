import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/price_with_indicator.dart';
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
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
  CommentModel(
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
  CommentModel(
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
  CommentModel(
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
  CommentModel(
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
  CommentModel(
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
  CommentModel(
    name: "Sothea",
    comment:
        "If you love nature, this place is for you, I love both environment and their service.",
    imgProfile: "assets/home/profile.png",
    ratestar: 4.5,
    like: 100,
    dislike: 2,
  ),
];

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  _SliverAppBarDelegate(this._tabBar);

  final TabBar _tabBar;

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(color: Colors.white, child: _tabBar);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return false;
  }
}

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

class _DetailTemplateState extends State<DetailTemplate>
    with SingleTickerProviderStateMixin {
  int currentImage = 0;
  PageController _imageController = PageController(initialPage: 0);
  TabController _tabController;
  ScrollPhysics _firstPagePhysics = NeverScrollableScrollPhysics();
  ScrollPhysics _secPagePhysics = NeverScrollableScrollPhysics();
  ScrollController _scrollController, _firstPageScrollCtr, _secPageScrollCtr;

  final bool isHasPrice = false;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(onTabChangedListener);

    _scrollController = ScrollController();
    _scrollController.addListener(wholePageListener);

    _firstPageScrollCtr = ScrollController();
    _firstPageScrollCtr.addListener(firstPageListener);

    _secPageScrollCtr = ScrollController();
    _secPageScrollCtr.addListener(secPageListener);

    super.initState();
  }

  onTabChangedListener() {
    setState(() {
      _firstPagePhysics = NeverScrollableScrollPhysics();
      _secPagePhysics = NeverScrollableScrollPhysics();
      if (isReachBottom(_scrollController)) {
        print("whole page reach the bottom");
        if (_tabController.index == 0)
          _firstPagePhysics = BouncingScrollPhysics();
        if (_tabController.index == 1)
          _secPagePhysics = BouncingScrollPhysics();
      }
    });
    print("change page");
  }

  wholePageListener() {
    if (isReachBottom(_scrollController)) {
      setState(() {
        print("whole page reach the bottom");
        if (_tabController.index == 0)
          _firstPagePhysics = BouncingScrollPhysics();
        if (_tabController.index == 1)
          _secPagePhysics = BouncingScrollPhysics();
      });
    }
  }

  firstPageListener() {
    if (isReachTop(_firstPageScrollCtr)) {
      setState(() {
        _firstPagePhysics = NeverScrollableScrollPhysics();
        print("first page reach the top");
      });
    }

    if (_firstPageScrollCtr.offset == 0 &&
        (_scrollController.position.userScrollDirection ==
                ScrollDirection.reverse ||
            _firstPageScrollCtr.position.userScrollDirection ==
                ScrollDirection.reverse)) {
      setState(() {
        _firstPagePhysics = BouncingScrollPhysics();
      });
      print("scrolling down");
    }
  }

  secPageListener() {
    if (isReachTop(_secPageScrollCtr)) {
      setState(() {
        _secPagePhysics = NeverScrollableScrollPhysics();
        print("second page reach the top");
      });
    }

    if (isReachBottom(_secPageScrollCtr)) {
      print("second page reach bottom");
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Palette.bg,
      body: CustomScrollView(
        physics: BouncingScrollPhysics(),
        controller: _scrollController,
        slivers: [
          SliverAppBar(
            titleSpacing: 0.0,
            toolbarHeight: 48,
            elevation: 0.3,
            forceElevated: true,
            expandedHeight: 150.0 + 150 - 27 + 50,
            backgroundColor: Palette.sky,
            pinned: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("អំពីរទីកន្លែង", style: TextStyle(color: Colors.white)),
            flexibleSpace: FlexibleSpaceBar(
              titlePadding: EdgeInsets.only(bottom: 10, left: 24 * 2.3),
              background: Column(
                children: [
                  Container(
                    width: width,
                    height: 150 + 50.0,
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
                  DetaiProfile(
                    title: "ភ្នំបូកគោបោះតង់",
                    width: width,
                    location: "ខេត្តកំពត",
                    onBookPressed: () {},
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            pinned: true,
            delegate: _SliverAppBarDelegate(
              TabBar(
                controller: _tabController,
                labelStyle: TextStyle(
                  fontSize: 13,
                  fontFamily: "Kantumruy",
                ),
                labelPadding: EdgeInsets.all(0),
                indicatorColor: Palette.sky,
                labelColor: Palette.sky,
                unselectedLabelColor: Palette.text,
                tabs: [
                  Tab(text: "អំពីទីតាំង"),
                  Tab(text: "មតិយោបល់"),
                ],
                onTap: (index) {
                  if (index == 0) {
                    setState(() {
                      _firstPagePhysics = NeverScrollableScrollPhysics();
                      print("change from tab[2]");
                    });
                  }
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  height: height - 75 - 48,
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      buildFirstPage(height, width),
                      buildSecPage(width),
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

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
    _imageController.dispose();
    _scrollController.dispose();
    _firstPageScrollCtr.dispose();
    _secPageScrollCtr.dispose();
  }

  isReachTop(ScrollController controller) {
    if (controller.offset <= controller.position.minScrollExtent &&
        !controller.position.outOfRange)
      return true;
    else
      return false;
  }

  isReachBottom(ScrollController controller) {
    if (controller.offset >= controller.position.maxScrollExtent &&
        !controller.position.outOfRange)
      return true;
    else
      return false;
  }

  ListView buildFirstPage(double height, double width) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      controller: _firstPageScrollCtr,
      physics: _firstPagePhysics,
      children: [
        Wrap(
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
        Text(
          "Term of Service | Privacy",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: "Open Sans",
            color: Palette.text,
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  ListView buildSecPage(double width) {
    return ListView(
      physics: _secPagePhysics,
      controller: _secPageScrollCtr,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      children: [
        for (int index = 0; index < comments.length; index++)
          Container(
            width: width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              boxShadow: [
                BoxShadow(
                  color: Colors.black87.withOpacity(0.1),
                  blurRadius: 10.0,
                  spreadRadius: -20,
                  offset: Offset(0, 25),
                )
              ],
              color: Colors.white,
            ),
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Image.asset(
                      comments[index].imgProfile,
                      width: 35,
                      height: 35,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(width: 10.0),
                    Container(
                      width: width - 35 - 40 - 10 - 20,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                comments[index].name,
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(right: 10.0),
                                child: StarRating(
                                    rating: comments[index].ratestar),
                              )
                            ],
                          ),
                          SizedBox(height: 5),
                          Text(
                            comments[index].comment,
                            style: TextStyle(
                              fontWeight: FontWeight.w300,
                            ),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(height: 5),
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
                            "300 ចូលចិត្ត",
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
                            "300 មិនចូលចិត្ត",
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
          )
      ],
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
