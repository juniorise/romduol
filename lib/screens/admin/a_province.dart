import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/admin/a_package.dart';
import 'package:romduol/screens/admin/add_to_province.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/widget/animatedList.dart';
import 'package:romduol/widget/pageroutetransition.dart';
import 'package:romduol/widget/theme.dart';

class AdminProvince extends StatefulWidget {
  AdminProvince({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;

  @override
  _AdminProvinceState createState() => _AdminProvinceState();
}

class _AdminProvinceState extends State<AdminProvince> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(title: "Province draft", isKH: widget.isKH),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageRouteTransition(
              child: AdminPackage(
                isKH: widget.isKH,
              ),
            ),
          );
        },
        child: Icon(Icons.switch_left),
      ),
      body: ListView(
        children: [
          SizedBox(height: 10),
          Container(
            width: width,
            height: 48,
            decoration: buildBoxDecoration(),
            child: FlatButton.icon(
              highlightColor: Palette.sky.withOpacity(0.3),
              height: 48,
              icon: Icon(
                Icons.add_rounded,
                color: Palette.sky,
              ),
              label: Text(
                "Add new data",
                style: TextStyle(
                  color: Palette.sky,
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddToProvince(isKH: widget.isKH),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection("userData")
                  .doc(user.uid)
                  .collection("provincedraft")
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  List<CardModel> _data = List();
                  List<Function> onTaps = List();

                  List<String> provinces = List(), categories = List();
                  snapshot.data.docs.forEach((element) {
                    print(element.reference.path);

                    categories.add(element.data()['category'] ?? "places");
                    provinces.add(element.data()['province'] ?? "kep");

                    _data.add(CardModel(
                      title: element.data()['title'] ?? "No title provided.",
                      location:
                          element.data()['location'] ?? "No location provided.",
                      thumbnail: element.data()['thumbnail'] ?? null,
                      id: element.data()['id'] ?? "No id provided.",
                      pricefrom: element.data()['pricefrom'] != null
                          ? element.data()['pricefrom'].toDouble()
                          : null ?? null,
                      pricetotal: element.data()['pricetotal'] != null
                          ? element.data()['pricetotal'].toDouble()
                          : null ?? null,
                      ratingaverage: element.data()['rating'] ?? null,
                      ratetotal: element.data()['ratetotal'] ?? null,
                      maplocation: element.data()['maplocation'] ?? null,
                      refpath: element.reference.path,
                      images: element.data()['images'] ?? [''],
                      articles: element.data()['articles'] ?? [''],
                      authur: element.data()['authur'] ?? null,
                    ));
                  });

                  for (int j = 0; j < _data.length; j++) {
                    onTaps.add(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddToProvince(
                            isKH: widget.isKH,
                            data: _data[j],
                            category: categories[j],
                            province: provinces[j],
                          ),
                        ),
                      );
                    });
                  }
                  return AnimatedLists(
                    data: _data,
                    isKH: widget.isKH,
                    onEditPressed: onTaps,
                    isIgnoring: true,
                  );
                }
                return loading();
              }),
        ],
      ),
    );
  }
}
