import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference packages = instance.collection('packages');

  List<PackageModel> _packagesFromSnapshot(QuerySnapshot snapshot) {
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
  }

  Stream<List<PackageModel>> get packagesData {
    return packages.snapshots().map((even) => _packagesFromSnapshot(even));
  }
}
