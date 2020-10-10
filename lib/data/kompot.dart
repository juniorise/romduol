import 'package:romduol/models/models.dart';

class KompotDatabase {
  List<CardModel> places() {
    List<CardModel> _places = [
      CardModel(
        title: "រង្វង់មូលធុរេន",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "place_roundedturen",
      ),
      CardModel(
        title: "ស្ថាបត្យកម្មបារាំងចំណាស់-ភ្នំបូកគោ",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "place_franceachitect",
      ),
      CardModel(
        title: "ឧទ្យានព្រែកចាក",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "place_prekjak",
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
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "acc_genesha",
        price: "15\$ - 25\$",
        ratestar: 4.5,
        ratetotal: 50,
      ),
      CardModel(
        title: "Eden ភូមិអេកូ",
        location: "ជាប់មាត់ព្រែកកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "acc_eden",
        price: "15\$ - 25\$",
        ratestar: 4.5,
        ratetotal: 50,
      ),
      CardModel(
        title: "Ramo រីសត",
        location: "2.3គីឡូម៉ែត្រពីរង្វង់មូលធូរេន",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "acc_ramo",
        price: "15\$ - 25\$",
        ratestar: 4.5,
        ratetotal: 50,
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
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "act_biking",
        price: "\$3 ក្នុងកង់",
        ratestar: 4.5,
        ratetotal: 50,
      ),
      CardModel(
        title: "ជិះទូកស្រូបយកខ្យល់បូរិសុទ្ធ",
        location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "act_boating",
        price: "\$3 ក្នុងម្នាក់",
        ratestar: 4.5,
        ratetotal: 50,
      ),
    ];
    return _activities;
  }

  List<CardModel> restaurants() {
    List<CardModel> _restaurants = [
      CardModel(
        title: "Epic Arts Cafe",
        location: "កំពង់កណ្ដាល, កំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "res_epicartcafe",
        price: "15\$ - 25\$",
        ratestar: 4.5,
        ratetotal: 50,
      ),
      CardModel(
        title: "ផ្ទះបៃតង",
        location: "ក្បែរមាត់ព្រែកកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "res_greenhouse",
        price: "15\$ - 25\$",
        ratestar: 4.5,
        ratetotal: 50,
      ),
      CardModel(
        title: "Tertulia",
        location: "កណ្ដាលក្រុងកំពត",
        imageLocation:
            "https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/packages%2Ftour_3day_kohrong.png?alt=media&token=80bb8cbb-f8ed-4893-b56d-99d9a19f7ae0",
        id: "res_tertulia",
        price: "15\$ - 25\$",
        ratestar: 4.5,
        ratetotal: 50,
      ),
    ];
    return _restaurants;
  }
}
