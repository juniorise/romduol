import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class Database {
  final CollectionReference packages =
      FirebaseFirestore.instance.collection('packages');

  List<PackageModel> _packagesFromSnapshot(QuerySnapshot snapshot) {
    // List<PackageModel> _packages = List();
    
    print(snapshot.docs[1]['title']);
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

    // for (int i = 0; i < snapshot.docs.length; i++) {
    //   _packages.add(PackageModel(
    //     imagelocation: snapshot.docs[i]['imagelocation'],
    //     total: snapshot.docs[i]['total'],
    //     booked: snapshot.docs[i]['booked'],
    //     title: snapshot.docs[i]['title'],
    //     location: snapshot.docs[i]['location'],
    //     date: snapshot.docs[i]['date'],
    //     price: snapshot.docs[i]['price'],
    //   ));
    // }

    // return _packages;
  }

  Stream<List<PackageModel>> get packagesData {
    return packages.snapshots().map((even) => _packagesFromSnapshot(even));
  }
}
