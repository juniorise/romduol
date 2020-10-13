import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/widget/detail_profile.dart';
import 'package:romduol/widget/image_viewer.dart';
import 'package:romduol/widget/price_with_indicator.dart';
import 'package:romduol/widget/sliver_card_delegate.dart';

class PackageDetail extends StatefulWidget {
  const PackageDetail({Key key}) : super(key: key);

  @override
  _PackageDetailState createState() => _PackageDetailState();
}

class _PackageDetailState extends State<PackageDetail> {
  int currentImage = 0;
  PageController _pageController = PageController(initialPage: 0);

  List<String> imageList = [
    "assets/provinces/sihanouk.png",
    "assets/provinces/kep.png",
    "assets/provinces/kohkong.png"
  ];

  void onImageClick(int index) {
    if (index == imageList.length - 1) {
      _pageController.animateToPage(
        0,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    } else {
      _pageController.animateToPage(
        index + 1,
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
            expandedHeight: 150.0 - 27 + 50,
            backgroundColor: Palette.sky,
            pinned: true,
            iconTheme: IconThemeData(color: Colors.white),
            title: Text("ដំណើរកំសាន្ត", style: TextStyle(color: Colors.white)),
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
                          pageController: _pageController,
                          imageList: imageList,
                          width: width,
                          currentImage: currentImage,
                          onPageChanged: (index) =>
                              setState(() => currentImage = index),
                        ),
                        TextWithIndicator(
                          currentImage: currentImage,
                          imageList: imageList,
                          text: "ចាប់ពី​ 10-11 កញ្ញា 2020",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPersistentHeader(
            floating: true,
            delegate: SliverCardDelegate(
              child: DetailProfile(
                title: "ភ្នំបូកគោបោះតង់",
                width: width,
                price: 25,
                location: "ខេត្តកំពត",
                onBookPressed: () {},
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
                  padding: EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 10,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ជាមួយកញ្ចប់សេវាកម្មដំណើរកំសាន្តមួយនេះអ្នកនឹងទទួលបានការរ៉ាប់រ៉ងលើការធ្វើដំណើរពីភ្នំពេញទៅកាន់ឧទ្យានជាតិបូកគោនិងត្រលប់មកវិញការទស្សនាសំណង់អគារបុរាណ តង់មួយសម្រាប់មនុស្សពីរនាក់ អារហារបីពេល​ និងសកម្មភាពជាច្រើនទៀត។",
                            style: TextStyle(fontSize: 13, color: Palette.text),
                          ),
                          article(
                            "ថ្ងៃទី1​ - ​10 កញ្ញា 2021",
                            "ចេញដំណើរពីភ្នំពេញទៅកាន់ខេត្តកំពតឆ្ពោះទៅកាន់់ឧទ្យានជាតិបូកគោព្រមទាំងមានការឈប់នៅតាមទីកន្លែងផ្សេងៗនៅលើភ្នំបូកគោដើម្បីទស្សនានិងថតរួចបន្តទៅកាន់គោលដៅបោះតង់រួមជាមួយនឹងការញុាំអាហារពេលល្ងាចជុំគ្នានិងល្បែងកំសាន្តជាច្រើនទៀតផងដែរ។",
                          ),
                          article(
                            "ថ្ងៃទី2 - ​11 កញ្ញា 2021",
                            "ធ្វើដំណើរទៅកាន់ទីកន្លែងប្រវត្តិសាស្រ្តនិងអគារបុរាណផ្សេងៗនិងស្វែងយល់ពីទីកន្លែងនីមួយៗព្រមទាំងមានការថតរូបអនុស្សាវរីយ៍ជុំគ្នាមុនពេលធ្វើដំណើរត្រលប់មកវិញ។",
                          ),
                          article(
                            "សំណួរគេសួរញឹកញាប់ | FAQ",
                            "ហេតុអ្វីត្រូវការអ្នកមគ្គុទេសក៏?\nមគ្គុទេសក៏ស្គាល់នូវភាពទាក់ទាញបំផុតនៃទីក្រុងរបស់ពួកគេនិងអាចផ្តល់នូវបទពិសោធន៍ដំណើរកំសាន្តដ៍អស្ចារ្យសម្រាប់អ្នក។",
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
                  ),
                )
              ],
            ),
          )
        ],
      ),
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
