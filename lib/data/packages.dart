import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

/// PACKAGE DATA
List<PackageModel> packages = [
  PackageModel(
    bookedspace: 12,
    date: "18-21 កញ្ញា 2021",
    thumbnail:
        "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
    location: "កោះកុង",
    price: 35,
    title: "ដំណើរកំសាន្តទៅកាន់កោះរុង3ថ្ងៃ",
    totalspace: 35,
    id: 'kohkong_kohrong_3day',
    maplocation: GeoPoint(11.562450, 104.916010),
    buslocation: GeoPoint(11.562450, 104.916010),
  ),
  PackageModel(
    bookedspace: 8,
    date: "10-11 កញ្ញា 2021",
    thumbnail:
        "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kompot.png?alt=media&token=1750d614-7714-4ddc-a2ac-31ad750c9c10",
    location: "ខេត្តកែប",
    price: 25,
    title: "ដំណើរកំសាន្តកែប៣ថ្ងៃ",
    totalspace: 25,
    id: 'keb_tour_3days',
    maplocation: GeoPoint(11.562450, 104.916010),
    buslocation: GeoPoint(11.562450, 104.916010),
  ),
  PackageModel(
    bookedspace: 13,
    date: "10-11 តុលា 2021",
    thumbnail:
        "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Fbostong_2day_1night_sihanouk.png?alt=media&token=441e5a13-aff1-40b6-b591-1aadb9e8da14",
    location: "ខេត្តព្រះសីហនុ",
    price: 15,
    title: "ភ្នំបូកគោបោះតង់2ថ្ងៃ1យប់",
    totalspace: 28,
    id: 'sihaknouk_bostong_2daynight',
    maplocation: GeoPoint(11.562450, 104.916010),
    buslocation: GeoPoint(11.562450, 104.916010),
  ),
  PackageModel(
    bookedspace: 8,
    date: "30-2 តុលា 2021",
    thumbnail:
        "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Fhiking_3day_kompot.png?alt=media&token=d681b68f-f4b3-4de1-b977-1bbfa04820de",
    location: "ខេត្តកំពត",
    price: 15,
    title: "ដំណើរកំសាន្តដើរព្រៃនៅកំពត",
    totalspace: 15,
    id: 'kompot_hiking_3days',
    maplocation: GeoPoint(11.562450, 104.916010),
    buslocation: GeoPoint(11.562450, 104.916010),
  )
];
