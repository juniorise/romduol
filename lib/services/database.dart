import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference packages = instance.collection('packages');

  //stream package data
  Stream<List<PackageModel>> get packagesData {
    return packages.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
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
    _pagesCard.removeRange(0, _pagesCard.length);
    
    for (int i = 0; i < _pages.length; i++) {
      _pagesCard.add([]);
    }
    for (int i = 0; i < _pages.length; i++) {
      String _page = _pages[i];
      instance
          .collection('$province/$_page/default_data')
          .snapshots()
          .forEach((element) {
        if (element != null)
          element.docs.forEach((element) {
            List<FoodMenu> foodMenu = List();
            if (_page == "restaurants" && element.data()['foodmenu'] != null) {
              List<dynamic> parentMap = element.data()['foodmenu'];
              parentMap.forEach((element) {
                foodMenu.add(
                  FoodMenu(
                    title: element['title'],
                    thumbnail: element['thumbnail'],
                    price: element['price'].toString(),
                  ),
                );
              });
            }

            List<CommentModel> comments = List();
            double ratetotal = 0.0;
            if (element.data()['comments'] != null) {
              List<dynamic> parentComment = element.data()['comments'];
              parentComment.forEach((element) {
                comments.add(CommentModel(
                  uid: element['uid'],
                  name: "Anonymous",
                  comment: element['comment'] ?? "empty",
                  rating: element['rate'],
                  profileimg: "",
                  date: element['date'],
                ));
                ratetotal += element['rate'];
              });
            }
            double lastrate =
                (((ratetotal / comments.length) * 100).roundToDouble()) / 100;

            for (double k = 0; k < 5; k += 0.5) {
              if (lastrate < k) {
                lastrate = k - 0.5;
                k = 5;
              }
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
              ratingaverage: !(ratetotal / 5).isNaN ? lastrate : 0,
              ratetotal: comments != null ? comments.length : 0,
              maplocation: element.data()['maplocation'] ?? null,
              refpath: element.reference.path,
              images: element.data()['images'],
              articles: element.data()['articles'],
              foodmenu: foodMenu.length > 0 ? foodMenu : null,
              comments: comments.length > 0 ? comments : null,
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
    return instance
        .collection('preahsihanouk')
        .snapshots()
        .map((_) => _pagesCard);
  }
}
