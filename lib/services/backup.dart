import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/data/kompot.dart';
import 'package:romduol/data/packages.dart';

class Backup {
  static FirebaseFirestore instance = FirebaseFirestore.instance;
  final CollectionReference _kompots = instance.collection('kompot');
  final CollectionReference _packages = instance.collection('packages');

  void autoBackupPackages() async {
    for (int i = 0; i < packages.length; i++) {
      await _packages.doc('${packages[i].id}').set(
        {
          'id': '${packages[i].id}',
          'bookedspace': packages[i].bookedspace,
          'date': "${packages[i].date}",
          'thumbnail': "${packages[i].thumbnail}",
          'location': "${packages[i].location}",
          'buslocation': packages[i].buslocation,
          'maplocation': packages[i].maplocation,
          'price': packages[i].price,
          'title': "${packages[i].title}",
          'totalspace': packages[i].totalspace,
        },
      );
    }
  }

  void autoBackupProvince() async {
    final province = _kompots;
    final accomodations = KompotDatabase().accomodations();
    final activities = KompotDatabase().activities();
    final restaurants = KompotDatabase().restaurants();
    final places = KompotDatabase().places();

    for (int i = 0; i < accomodations.length; i++) {
      await province
          .doc('accomodations')
          .collection('default_data')
          .doc('${accomodations[i].id}')
          .set(
        {
          "title": "${accomodations[i].title}",
          "location": "${accomodations[i].location}",
          "thumbnail": "${restaurants[i].thumbnail}",
          "id": "${accomodations[i].id}",
          "pricefrom": accomodations[i].pricefrom,
          "pricetotal": accomodations[i].pricetotal,
          "rating": accomodations[i].ratingaverage,
          "ratetotal": accomodations[i].ratetotal,
          "maplocation": accomodations[i].maplocation,
        },
      );
    }

    for (int i = 0; i < activities.length; i++) {
      await province
          .doc('activities')
          .collection('default_data')
          .doc('${activities[i].id}')
          .set(
        {
          "title": "${activities[i].title}",
          "location": "${activities[i].location}",
          "thumbnail": "${activities[i].thumbnail}",
          "id": "${activities[i].id}",
          "pricefrom": accomodations[i].pricefrom,
          "pricetotal": accomodations[i].pricetotal,
          "rating": accomodations[i].ratingaverage,
          "ratetotal": activities[i].ratetotal,
          "maplocation": accomodations[i].maplocation
        },
      );
    }

    for (int i = 0; i < restaurants.length; i++) {
      await province
          .doc('restaurants')
          .collection('default_data')
          .doc('${restaurants[i].id}')
          .set(
        {
          "title": "${restaurants[i].title}",
          "location": "${restaurants[i].location}",
          "thumbnail": "${restaurants[i].thumbnail}",
          "id": "${restaurants[i].id}",
          "pricefrom": accomodations[i].pricefrom,
          "pricetotal": accomodations[i].pricetotal,
          "rating": accomodations[i].ratingaverage,
          "ratetotal": restaurants[i].ratetotal,
          "maplocation": accomodations[i].maplocation
        },
      );
    }

    for (int i = 0; i < places.length; i++) {
      province
          .doc('places')
          .collection('default_data')
          .doc('${places[i].id}')
          .set(
        {
          "title": "${places[i].title}",
          "location": "${places[i].location}",
          "thumbnail": "${restaurants[i].thumbnail}",
          "id": "${places[i].id}",
          "maplocation": accomodations[i].maplocation
        },
      );
    }
  }
}
