import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference packages = instance.collection('packages');

  Stream<List<PackageModel>> get packagesData {
    return packages.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PackageModel(
          imagelocation: doc.data()['imagelocation'],
          total: doc.data()['total'],
          booked: doc.data()['booked'],
          title: doc.data()['title'],
          location: doc.data()['location'],
          date: doc.data()['date'],
          price: doc.data()['price'],
        );
      }).toList();
    });
  }

  List<List<CardModel>> _provinceFromSnapshot(String province) {
    List<String> _pages = ['places', 'accomodations', 'activities', 'restaurants'];
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
            imageLocation: element.data()['imageLocation'] ?? null,
            id: element.data()['id'] ?? "No id provided.",
            price: element.data()['price'] ?? null,
            ratestar: element.data()['ratestar'] ?? null,
            ratetotal: element.data()['ratetotal'] ?? null,
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
