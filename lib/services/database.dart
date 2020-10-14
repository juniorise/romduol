import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference packages = instance.collection('packages');

  Stream<List<PackageModel>> get packagesData {
    return packages.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        print(doc.reference.path);
        return PackageModel(
          thumbnail: doc.data()['thumbnail'],
          totalspace: doc.data()['totalspace'],
          bookedspace: doc.data()['bookedspace'],
          title: doc.data()['title'],
          location: doc.data()['location'],
          date: doc.data()['date'],
          price: doc.data()['price'],
          refpath: doc.reference.path,
          maplocation: doc.data()['maplocation'],
          buslocation: doc.data()['buslocation'],
        );
      }).toList();
    });
  }

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
          _pagesCard[i].add(CardModel(
            title: element.data()['title'] ?? "No title provided.",
            location: element.data()['location'] ?? "No location provided.",
            thumbnail: element.data()['thumbnail'] ?? null,
            id: element.data()['id'] ?? "No id provided.",
            pricefrom: element.data()['pricefrom'] ?? null,
            pricetotal: element.data()['pricetotal'] ?? null,
            rating: element.data()['rating'] ?? null,
            ratetotal: element.data()['ratetotal'] ?? null,
            maplocation: element.data()['maplocation'] ?? null,
            refpath: element.reference.path,
          ));
        });
      });
    }

    return _pagesCard;
  }

  Stream<List<List<CardModel>>> get kompotData {
    print('kompotData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('kompot');
    return instance.collection('kompot').snapshots().map((_) => _pagesCard);
  }

  Stream<List<List<CardModel>>> get kohkongData {
    print('kohkongData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('kohkong');
    return instance.collection('kohkong').snapshots().map((_) => _pagesCard);
  }

  Stream<List<List<CardModel>>> get kebData {
    print('kebData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('keb');
    return instance.collection('keb').snapshots().map((_) => _pagesCard);
  }

  Stream<List<List<CardModel>>> get sihaknoukData {
    print('sihaknoukData');
    List<List<CardModel>> _pagesCard = _provinceFromSnapshot('sihanouk');
    return instance.collection('sihanouk').snapshots().map((_) => _pagesCard);
  }
}
