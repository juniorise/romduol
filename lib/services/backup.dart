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
          'booked': packages[i].booked,
          'date': "${packages[i].date}",
          'imagelocation': "${packages[i].imagelocation}",
          'location': "${packages[i].location}",
          'price': packages[i].price,
          'title': "${packages[i].title}",
          'total': packages[i].total,
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
          "imageLocation":
              "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
          "id": "${accomodations[i].id}",
          "price": "${accomodations[i].price}",
          "ratestar": accomodations[i].ratestar,
          "ratetotal": accomodations[i].ratetotal,
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
          "imageLocation":
              "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
          "id": "${activities[i].id}",
          "price": "${activities[i].price}",
          "ratestar": activities[i].ratestar,
          "ratetotal": activities[i].ratetotal,
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
          "imageLocation":
              "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
          "id": "${restaurants[i].id}",
          "price": "${restaurants[i].price}",
          "ratestar": restaurants[i].ratestar,
          "ratetotal": restaurants[i].ratetotal,
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
          "imageLocation":
              "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
          "id": "${places[i].id}",
        },
      );
    }
  }
}
