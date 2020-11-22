import 'dart:async';
import 'package:auto_animated/auto_animated.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/configs/scrollnotifer.dart';
import 'package:romduol/data/data.dart';
import 'package:romduol/lang/lang.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/myapp.dart';
import 'package:romduol/screens/home/notification.dart';
import 'package:romduol/screens/province/province.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/user_data.dart';
import 'package:romduol/widget/drawer.dart';
import 'package:romduol/widget/homewelcometext.dart';
import 'package:romduol/widget/package_card.dart';
import 'package:romduol/widget/poster_card.dart';
import 'package:romduol/widget/province_card.dart';
import 'package:romduol/widget/theme.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  final Function onTab;
  const HomePage({Key key, this.onTab}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  ScrollController _scrollController;
  Timer timer;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  //isInit use for load animation for province (is init => not load)
  bool isKH = true, isInit = false, isQuestionChanging = false;
  int qindex = 0;
  double opacity = 1;

  AnimationController _animationController;
  AnimationController _appBarController;
  Animation<double> _appBarSize;

  final sizeNotifier = ValueNotifier<double>(0);

  @override
  void initState() {
    _scrollController = ScrollController();
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 450));

    _appBarController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _appBarSize = Tween<double>(begin: 0, end: 47).animate(_appBarController)
      ..addListener(() => sizeNotifier.value = _appBarSize.value);

    qindex = math.Random().nextInt(question.length - 1);
    timer =
        Timer.periodic(Duration(seconds: 20), (Timer t) => changeTextValue());
    getLang();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _appBarController.dispose();
    _animationController.dispose();
    timer?.cancel();
    super.dispose();
  }

  void changeTextValue() async {
    int _tmp = 0;
    setState(() => isQuestionChanging = true);

    await Future.delayed(Duration(milliseconds: 300));
    do {
      _tmp = math.Random().nextInt(question.length - 1);
    } while (_tmp == qindex);

    qindex = _tmp;
    setState(() => isQuestionChanging = false);
  }

  void getLang() async {
    isKH = await Lang().isKH();
    setState(() {
      if (isKH == null) {
        Lang().setLang(true);
        isKH = true;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<PackageModel> packages =
        Provider.of<List<PackageModel>>(context) ?? [];

    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    final user = Provider.of<CustomUser>(context);

    return ChangeNotifierProvider(
      create: (_) => ScrollNotifier(_scrollController),
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          key: scaffoldKey,
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(48),
            child: Consumer<ScrollNotifier>(
              builder: (context, notifier, child) {
                return buildAppBar(
                  title: Lang().of(key: 'title', isKH: isKH),
                  onTab: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        child: NotificationScreen(isKH: isKH),
                        type: PageTransitionType.fade,
                        curve: Curves.ease,
                        duration: const Duration(milliseconds: 150),
                      ),
                    );
                  },
                  leading: IconButton(
                    icon: AnimatedOpacity(
                      opacity: opacity,
                      duration: Duration(milliseconds: 350),
                      child: AnimatedIcon(
                        icon: AnimatedIcons.menu_arrow,
                        progress: _animationController,
                      ),
                    ),
                    onPressed: () {
                      scaffoldKey.currentState.openDrawer();
                    },
                  ),
                  elevation: math.min(notifier.offset * 0.05, 0.5),
                  isKH: isKH,
                );
              },
            ),
          ),
          drawer: HomeDrawer(
            onLangTab: () => setState(() {
              isKH = !isKH;
              Lang().setLang(isKH);

              Navigator.pushReplacement(
                context,
                PageTransition(
                  child: MyApp(),
                  type: PageTransitionType.fade,
                  curve: Curves.ease,
                  duration: const Duration(milliseconds: 150),
                ),
              );
            }),
            onWillPop: _onWillPop,
            isKH: isKH,
          ),
          body: RefreshIndicator(
            onRefresh: () async {
              return changeTextValue();
            },
            child: GestureDetector(
              onHorizontalDragEnd: (e) {
                if (e.velocity.pixelsPerSecond.direction > 0 &&
                    e.velocity.pixelsPerSecond.dx > 0)
                  scaffoldKey.currentState.openDrawer();
              },
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    top: -80 - 30.0,
                    child: Stack(
                      children: [
                        Container(
                          height: height * 0.85,
                          constraints: const BoxConstraints(minHeight: 620),
                          width: width,
                          child: Consumer<ScrollNotifier>(
                            builder: (context, notifier, child) {
                              return Transform.translate(
                                offset: Offset(0, notifier.offset * 0.2),
                                child: child,
                              );
                            },
                            child: Image.asset(
                              "assets/home/background.jpg",
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned.fill(
                          child: Container(
                            color: Palette.sky.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                  StreamBuilder<UserData>(
                    stream: UserDatabase(uid: user != null ? user.uid : null)
                        .userData,
                    builder: (context, usnapshot) {
                      if (usnapshot == null) _auth.signInAnonymously();
                      return ListView(
                        controller: _scrollController,
                        physics: RangeMaintainingScrollPhysics(),
                        children: [
                          //HELLO TITLE
                          HomeWecomeText(
                            isKH: isKH,
                            isQuestionChanging: isQuestionChanging,
                            width: width,
                            question: question[qindex],
                            name: usnapshot.hasData
                                ? " " + usnapshot.data.fname
                                : "! ស្វាគមន៍មកកាន់រំដួល",
                          ),

                          Container(
                            color: Palette.bg,
                            child: Column(
                              children: [
                                //PROVINCES
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 10, horizontal: 15),
                                  width: width,
                                  decoration: buildBoxDecoration(),
                                  child: Column(
                                    children: [
                                      sectionTitle(
                                        context: context,
                                        isKH: isKH,
                                        title: Lang().of(
                                          key: 'chooseaprovince',
                                          isKH: isKH,
                                        ),
                                      ),
                                      Container(
                                        height: width > 360 ? 155 : 290,
                                        child: LiveGrid.options(
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          options: options,
                                          itemCount: 4,
                                          gridDelegate:
                                              SliverGridDelegateWithFixedCrossAxisCount(
                                            crossAxisCount:
                                                width > 360 * 2 ? 4 : 2,
                                            crossAxisSpacing: 0,
                                            mainAxisSpacing: 0,
                                            childAspectRatio: 8 / 7,
                                          ),
                                          itemBuilder: (context, i, animation) {
                                            dynamic data = provinces[i];

                                            String collectionPath =
                                                "${data.id}/viewer/default_data/";

                                            return StreamBuilder<QuerySnapshot>(
                                              stream: FirebaseFirestore.instance
                                                  .collection(collectionPath)
                                                  .snapshots(),
                                              builder: (context, snapshot) {
                                                int view = 0;
                                                if (snapshot.hasData)
                                                  view = snapshot.data.size;

                                                return FadeTransition(
                                                  opacity: Tween<double>(
                                                    begin: !isInit ? 0 : 1,
                                                    end: 1,
                                                  ).animate(animation),
                                                  child: ProvinceCard(
                                                    isKH: isKH,
                                                    views: view,
                                                    province: isKH
                                                        ? data.province
                                                        : data.enprovince,
                                                    imagelocation:
                                                        data.imagelocation,
                                                    onPressed: () =>
                                                        onProvincePressed(
                                                      user: user,
                                                      collectionPath:
                                                          collectionPath,
                                                      data: data,
                                                      usnapshot: usnapshot,
                                                    ),
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20.0),

                                //ECO TRAVEL PACKAGE
                                Container(
                                  decoration: buildBoxDecoration(),
                                  padding: const EdgeInsets.all(15),
                                  width: width,
                                  child: Column(
                                    children: [
                                      PosterCard(
                                        isKH: isKH,
                                        width: width,
                                        isEditable: usnapshot != null &&
                                                usnapshot.data != null &&
                                                usnapshot.data.role == "Admin"
                                            ? true
                                            : false,
                                      ),
                                      const SizedBox(height: 5),
                                      sectionTitle(
                                        context: context,
                                        title: Lang()
                                            .of(key: 'joinwithus', isKH: isKH),
                                        isKH: isKH,
                                      ),
                                      packages.length > 0
                                          ? LiveList.options(
                                              shrinkWrap: true,
                                              physics:
                                                  NeverScrollableScrollPhysics(),
                                              options: options,
                                              itemCount: packages.length,
                                              itemBuilder: (context, i, anim) {
                                                return packages != null
                                                    ? FadeTransition(
                                                        opacity: Tween<double>(
                                                          begin: 0,
                                                          end: 1,
                                                        ).animate(anim),
                                                        child: PackageCard(
                                                          animationController:
                                                              _animationController,
                                                          isKH: isKH,
                                                          width: width,
                                                          package: packages[i],
                                                          onErrorPressed: () {},
                                                          index: i,
                                                        ),
                                                      )
                                                    : loading();
                                              },
                                            )
                                          : noData(),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),

                  //animation on navigate to province page
                  Positioned(
                    top: 0,
                    child: ValueListenableBuilder(
                      valueListenable: sizeNotifier,
                      builder: (_, value, __) => Container(
                        height: value,
                        width: width,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onProvincePressed({
    @required CustomUser user,
    @required String collectionPath,
    @required ProvinceModel data,
    @required dynamic usnapshot,
  }) async {
    setState(() => opacity = 0);
    _animationController.forward();
    _appBarController.forward();

    if (user != null) {
      Timestamp now = Timestamp.now();
      FirebaseFirestore.instance.doc(collectionPath + "${user.uid}").set(
            ({
              'uid': user.uid,
              'date': now,
            }),
          );
    }

    await Navigator.push(
      context,
      PageTransition(
        child: Province(
          province: data.province,
          enprovince: data.enprovince,
          isKH: isKH,
          user: usnapshot.data,
        ),
        type: PageTransitionType.fade,
        curve: Curves.ease,
        duration: Duration(
          milliseconds: 300,
        ),
      ),
    );

    setState(() => opacity = 1);
    _animationController.reverse();
    _appBarController.reverse();
  }

  final options = LiveOptions(
    showItemInterval: Duration(milliseconds: 100),
    showItemDuration: Duration(milliseconds: 500),
    visibleFraction: 0.05,
    reAnimateOnVisibility: false,
  );

  Future<bool> _onWillPop() {
    return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            titlePadding: EdgeInsets.fromLTRB(15, 15, 15, 0),
            contentPadding: EdgeInsets.only(left: 15),
            actionsPadding: EdgeInsets.only(right: 5),
            title: Text(
              Lang().of(key: 'doyouwantexitapp', isKH: isKH),
              style: TextStyle(
                color: Colors.white,
                fontSize: 16,
              ),
            ),
            content: Text(
              isKH ? 'សូមចុច "បាទ/ចាស"' : "Please click on 'Yes'",
              style: TextStyle(
                color: Colors.white,
                fontSize: 13,
                fontFamily: 'Kantumruy',
              ),
            ),
            backgroundColor: Palette.sky,
            actions: <Widget>[
              FlatButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(false),
                child: Text(
                  isKH ? "ទេ" : "No",
                  style: TextStyle(
                    color: Palette.sky,
                    fontSize: 14,
                    fontFamily: 'Kantumruy',
                  ),
                ),
              ),
              FlatButton(
                color: Colors.white,
                onPressed: () => Navigator.of(context).pop(true),
                child: Text(
                  isKH ? "បាទ/ចាស" : "Yes",
                  style: TextStyle(
                    color: Palette.sky,
                    fontSize: 14,
                    fontFamily: 'Kantumruy',
                  ),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }
}
