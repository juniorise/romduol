import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/pagenotifier.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/admin/add_to_province.dart';
import 'package:romduol/services/user_data.dart';
import 'package:romduol/widget/animatedList.dart';
import 'package:romduol/widget/animatedtabbar.dart';
import 'package:romduol/widget/fadeinout.dart';
import 'package:romduol/services/database.dart';
import 'package:romduol/widget/theme.dart';
import 'package:preload_page_view/preload_page_view.dart';

class Province extends StatefulWidget {
  final String province, enprovince;
  final bool isKH;
  final UserData user;
  const Province({
    Key key,
    @required this.province,
    @required this.enprovince,
    @required this.isKH,
    this.user,
  }) : super(key: key);
  @override
  _ProvinceState createState() => _ProvinceState();
}

class _ProvinceState extends State<Province> {
  PreloadPageController _pageController;
  ScrollController _scrollController = ScrollController();
  bool isSearching = false;
  bool isSearched = false;
  int currentPage = 0;
  String refpath;
  TextEditingController _textEditingController = TextEditingController();
  List<CardModel> data = List();

  @override
  void initState() {
    super.initState();
    _pageController = PreloadPageController(initialPage: currentPage);
    _pageController.addListener(pageControllerListener);
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _scrollController.dispose();
    _textEditingController.dispose();
  }

  List<List<Function>> onTaps = List();

  List<bool> isAnimated = [false, true, true, true];

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<List<CardModel>>>.value(
      value: _checkProvince(),
      builder: (context, snapshot) {
        List<List<CardModel>> pagesCard =
            Provider.of<List<List<CardModel>>>(context) ?? [[]];

        for (int i = 0; i < pagesCard.length; i++) {
          List<Function> _onTapsTMP = List();
          for (int j = 0; j < pagesCard[i].length; j++) {
            _onTapsTMP.add(() {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddToProvince(
                    isKH: widget.isKH,
                    data: pagesCard[i][j],
                  ),
                ),
              );
            });
          }
          onTaps.insert(i, _onTapsTMP);
        }
        return ChangeNotifierProvider(
          create: (e) => PageViewNotifier(_pageController),
          child: Scaffold(
            appBar: PreferredSize(
              preferredSize: Size.fromHeight(48.0 + 46.0),
              child: AppBar(
                titleSpacing: 0.0,
                elevation: 0.5,
                actions: [
                  IconButton(
                    icon: Icon(isSearching ? Icons.clear : Icons.search),
                    onPressed: onSearchPressed,
                  )
                ],
                title: isSearching
                    ? _buildSearchField(currentPage, pagesCard)
                    : buildTitle(),
                bottom: PreferredSize(
                  child: AnimatedTabBar(
                    pageController: _pageController,
                    currentPage: currentPage,
                    scrollController: _scrollController,
                    onTap: (index) => removeAnimated(index),
                    isKH: widget.isKH,
                  ),
                  preferredSize: Size.fromHeight(46),
                ),
              ),
            ),
            body: PreloadPageView(
              physics: BouncingScrollPhysics(),
              controller: _pageController,
              onPageChanged: (page) {
                itsAnimated(currentPage);
                if (isSearched && _textEditingController.text != null)
                  onSubmitted(_textEditingController.text, pagesCard[page]);
                setState(
                  () => currentPage = page,
                );
              },
              children: <Widget>[
                for (int i = 0; i < pagesCard.length; i++)
                  FadeInOut(
                    index: i,
                    child: AnimatedLists(
                      data: !isSearched ? pagesCard[i] : data,
                      isAnimated: isAnimated[i],
                      isKH: widget.isKH,
                      onEditPressed: isEditable() ? onTaps[i] : null,
                      onPop: () {
                        setState(() {
                          pagesCard.removeRange(0, pagesCard.length);
                          pagesCard = Provider.of<List<List<CardModel>>>(
                                  context,
                                  listen: false) ??
                              [[]];
                        });
                      },
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSearchField(int pageCurrent, List<List<CardModel>> pagesCard) {
    return TextField(
      autofocus: true,
      decoration: InputDecoration(
        hintText: widget.isKH
            ? "ស្វែងរកក្នុង${widget.province}..."
            : "Search in ${widget.enprovince}...",
        border: InputBorder.none,
        hintStyle: TextStyle(
          color: Palette.text,
          fontSize: widget.isKH ? 14 : 15,
        ),
      ),
      style: TextStyle(
        color: Palette.text,
        fontSize: widget.isKH ? 14 : 15,
      ),
      textInputAction: TextInputAction.search,
      onChanged: (value) => onSubmitted(value, pagesCard[pageCurrent]),
      controller: _textEditingController,
    );
  }

  Widget buildTitle() => GestureDetector(
        onTap: onSearchPressed,
        child: Container(
          width: double.infinity,
          child: Text(
            widget.isKH
                ? "ស្វែងរកក្នុង${widget.province}..."
                : "Search in ${widget.enprovince}...",
            style: TextStyle(
              fontSize: widget.isKH ? 14 : 15,
              color: Palette.sky,
            ),
            textAlign: TextAlign.start,
          ),
        ),
      );

  Stream<List<List<CardModel>>> _checkProvince() {
    Stream<List<List<CardModel>>> _province;

    if (widget.province == "ខេត្តកំពត") {
      _province = Database().kompotData;
      refpath = "kompot/";
    }
    if (widget.province == "ខេត្តកោះកុង") {
      _province = Database().kohkongData;
      refpath = "kohkong/";
    }
    if (widget.province == "ខេត្តព្រះសីហនុ") {
      _province = Database().sihaknoukData;
      refpath = "preahsihanouk/";
    }
    if (widget.province == "ខេត្តកែប") {
      _province = Database().kebData;
      refpath = "keb/";
    }
    return _province;
  }

  void onSubmitted(String value, List<CardModel> pagesCard) {
    value = value.trim();
    if (value == "")
      setState(() => isSearched = false);
    else {
      if (data != null) data.removeRange(0, data.length);
      for (int i = 0; i < pagesCard.length; i++) {
        if (pagesCard[i].title.contains(value) ||
            pagesCard[i].location.contains(value) ||
            khNum(pagesCard[i].location, widget.isKH).contains(value) ||
            pagesCard[i].location.contains(khNum(value, widget.isKH))) {
          data.add(pagesCard[i]);
        }
      }
      setState(() => isSearched = true);
    }
  }

  //this may use in future
  void searchViaFirebase(String value, int pageCurrent) {
    value = value.trim();
    for (int i = 0; i < value.length; i++) print(value[i]);
    if (value == "")
      setState(() => isSearched = false);
    else {
      List<String> _path = [
        'places/default_data',
        'accomodations/default_data',
        'activities/default_data',
        'restaurants/default_data',
      ];
      String _ref = refpath + _path[pageCurrent];
      if (data != null) data.removeRange(0, data.length);
      FirebaseFirestore.instance
          .collection(_ref)
          .snapshots()
          .forEach((element) {
        element.docs.forEach((element) {
          setState(() => isSearched = true);
          if (element['title'].contains(value))
            data.add(CardModel(
              title: element['title'] ?? "No title provided.",
              location: element['location'] ?? "No location provided.",
              thumbnail: element['thumbnail'] ?? null,
              id: element['id'] ?? "No id provided.",
              pricefrom: element['pricefrom'] ?? null,
              pricetotal: element['pricetotal'] ?? null,
              ratingaverage: element['rating'] ?? null,
              ratetotal: element['ratetotal'] ?? null,
              maplocation: element['maplocation'] ?? null,
              refpath: element.reference.path,
            ));
        });
      });
      setState(() => isSearched = true);
    }
  }

  void onSearchPressed() => setState(() {
        isSearching = !isSearching;
        isSearched = false;
        _textEditingController.clear();
      });

  void itsAnimated(int index) {
    setState(() => isAnimated[index] = true);
    // print("Page[${index.toString()}] is animated [${isAnimated[index]}]");
  }

  void removeAnimated(int index) {
    setState(() => isAnimated[index] = false);
    // print("Page[${index.toString()}] is not animated [${isAnimated[index]}]");
  }

  //check if page view is scrolling => animate scroller controller
  void pageControllerListener() {
    if (_pageController.position.isScrollingNotifier.value) {
      _scrollController.jumpTo(
        //1 page view = 0.19 scroll view
        _pageController.offset * (0.19),
      );
    }
  }

  bool isEditable() {
    if (widget.user != null) {
      if (widget.user.role == "Admin") {
        return true;
      }
    }
    return false;
  }
}
