import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:romduol/models/models.dart';

class KompotDatabase {
  List<CardModel> places() {
    List<CardModel> _places = [
      CardModel(
        title: "រង្វង់មូលធុរេន",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "place_roundedturen",
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "ស្ថាបត្យកម្មបារាំងចំណាស់-ភ្នំបូកគោ",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "place_franceachitect",
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "ឧទ្យានព្រែកចាក",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "place_prekjak",
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
    ];
    return _places;
  }

  List<CardModel> accomodations() {
    /// ACCOMODATIONS DATA
    List<CardModel> _accomodations = [
      CardModel(
        title: "Ganesha ផ្ទះសំណាក់អេកូ",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "acc_genesha",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "Eden ភូមិអេកូ",
        location: "ជាប់មាត់ព្រែកកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "acc_eden",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "Ramo រីសត",
        location: "2.3គីឡូម៉ែត្រពីរង្វង់មូលធូរេន",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "acc_ramo",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
    ];
    return _accomodations;
  }

  List<CardModel> activities() {
    /// ACTITIVIES DATA
    List<CardModel> _activities = [
      CardModel(
        title: "ជិះកង់មើលទេសភាពនៅក្នុងតំបន់ទេសចរណ៍",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "act_biking",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "ជិះទូកស្រូបយកខ្យល់បូរិសុទ្ធ",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "act_boating",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
    ];
    return _activities;
  }

  List<CardModel> restaurants() {
    List<CardModel> _restaurants = [
      CardModel(
        title: "Epic Arts Cafe",
        location: "កំពង់កណ្ដាល, កំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "res_epicartcafe",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "ផ្ទះបៃតង",
        location: "ក្បែរមាត់ព្រែកកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "res_greenhouse",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
      CardModel(
        title: "Tertulia",
        location: "កណ្ដាលក្រុងកំពត",
        thumbnail:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "res_tertulia",
        pricefrom: 15,
        pricetotal: 25,
        ratingaverage: 4.5,
        ratetotal: 50,
        maplocation: GeoPoint(11.562450, 104.916010)
      ),
    ];
    return _restaurants;
  }
}
