import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference packages = instance.collection('packages');

  //stream package data
  Stream<List<PackageModel>> get packagesData {
    return packages.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        print(doc.reference.path);
        return PackageModel(
          thumbnail: doc.data()['thumbnail'] ?? null,
          totalspace: doc.data()['totalspace'] ?? null,
          bookedspace: doc.data()['bookedspace'] ?? null,
          title: doc.data()['title'] ?? null,
          location: doc.data()['location'] ?? null,
          date: doc.data()['date'] ?? null,
          price: doc.data()['price'].toDouble() ?? null,
          refpath: doc.reference.path ?? null,
          maplocation: doc.data()['maplocation'] ?? null,
          buslocation: doc.data()['buslocation'] ?? null,
        );
      }).toList();
    });
  }

  //stream province data
  List<List<CardModel>> _provinceFromSnapshot(String province) {
    List<String> _pages = [
      'places',
      'accomodations',
      'activities',
      'restaurants'
    ];
    List<List<CardModel>> _pagesCard = [[], [], [], []];

    for (int i = 0; i < _pages.length; i++) {
      String _page = _pages[i];
      instance
          .collection('$province')
          .doc(_page)
          .collection('default_data')
          .snapshots()
          .forEach((element) {
        element.docs.forEach((element) {
          List<FoodMenu> foodMenu = List();
          if (_page == "restaurants") {
            List<dynamic> parentMap = element.data()['foodmenu'];
            parentMap.forEach((element) {
              print(element['title']);
              print(element['thumbnail']);
              foodMenu.add(
                FoodMenu(
                  title: element['title'],
                  thumbnail: element['thumbnail'],
                  price: element['price'].toString(),
                ),
              );
            });
          }
          
          _pagesCard[i].add(CardModel(
            title: element.data()['title'] ?? "No title provided.",
            location: element.data()['location'] ?? "No location provided.",
            thumbnail: element.data()['thumbnail'] ?? null,
            id: element.data()['id'] ?? "No id provided.",
            pricefrom: element.data()['pricefrom'] != null
                ? element.data()['pricefrom'].toDouble()
                : null ?? null,
            pricetotal: element.data()['pricetotal'] != null
                ? element.data()['pricetotal'].toDouble()
                : null ?? null,
            rating: element.data()['rating'] ?? null,
            ratetotal: element.data()['ratetotal'] ?? null,
            maplocation: element.data()['maplocation'] ?? null,
            refpath: element.reference.path,
            images: element.data()['images'],
            articles: element.data()['articles'],
            foodmenu: foodMenu.length > 0 ? foodMenu : null,
          ));
        });
      });
    }
    return _pagesCard;
  }

  //stream data for kompot
  Stream<List<List<CardModel>>> get kompotData {
    print('kompotData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('kompot');
    return instance.collection('kompot').snapshots().map((_) => _pagesCard);
  }

  //stream data for kompot
  Stream<List<List<CardModel>>> get kohkongData {
    print('kohkongData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('kohkong');
    return instance.collection('kohkong').snapshots().map((_) => _pagesCard);
  }

  //stream data for kompot
  Stream<List<List<CardModel>>> get kebData {
    print('kebData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('keb');
    return instance.collection('keb').snapshots().map((_) => _pagesCard);
  }

  //stream data for kompot
  Stream<List<List<CardModel>>> get sihaknoukData {
    print('sihaknoukData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('preahsihanouk');
    return instance.collection('preahsihanouk').snapshots().map((_) => _pagesCard);
  }
}
