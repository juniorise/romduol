import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference packages = instance.collection('packages');
  final CollectionReference kompot = instance.collection('kompot');

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

  List<List<CardModel>> provinceFromSnapshot(String province) {
    List<String> pages = ['places', 'accomodations', 'activities', 'foods'];
    List<List<CardModel>> pagesCard = [[], [], [], []];

    for (int i = 0; i < pages.length; i++) {
      String page = pages[i];
      instance
          .collection('$province')
          .doc(page)
          .collection('default_data')
          .snapshots()
          .forEach((element) {
        element.docs.forEach((element) {
          pagesCard[i].add(CardModel(
            title: element.data()['title'] ?? "No title provided.",
            location: element.data()['location'] ?? "No location provided.",
            imageLocation: element.data()['imageLocation'] ?? null,
            id: element.data()['id'] ?? "No id provided.",
            price: element.data()['price'] ?? null,
            ratestar: element.data()['ratestar'] ?? null,
          ));
        });
      });
    }
    return pagesCard;
  }

  Stream<List<List<CardModel>>> get kompotData {
    List<List<CardModel>> pagesCard = provinceFromSnapshot('kompot');
    return instance.collection('kompot').snapshots().map((_) => pagesCard);
  }
}
