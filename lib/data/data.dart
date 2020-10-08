import 'package:romduol/models/models.dart';

/////////////////////////
/// PROVINCE
List<ProvinceModel> provinces = [
  ProvinceModel(
    province: "ខេត្តកំពត",
    views: 10,
    imagelocation: "assets/provinces/kompot.png",
  ),
  ProvinceModel(
    province: "ខេត្តកោះកុង",
    views: 10,
    imagelocation: "assets/provinces/kohkong.png",
  ),
  ProvinceModel(
    province: "ខេត្តព្រះសីហនុ",
    views: 10,
    imagelocation: "assets/provinces/sihanouk.png",
  ),
  ProvinceModel(
    province: "ខេត្តកែប",
    views: 10,
    imagelocation: "assets/provinces/kep.png",
  )
];

/////////////////////////
/// PACKAGE DATA
List<PackageModel> packages = [
  PackageModel(
    imagelocation: "assets/provinces/kompot.png",
    total: 25,
    booked: 8,
    title: "ភ្នំបូកគោបោះតង់2ថ្ងៃ1យប់",
    location: "ខេត្តកំពត",
    date: "10-11 កញ្ញា 2021",
    price: 25,
  ),
  PackageModel(
    imagelocation: "assets/activities/kompot/kohrong.png",
    total: 35,
    booked: 16,
    title: "ដំណើរកំសាន្តទៅកាន់កោះរុង3ថ្ងៃ",
    location: "កោះកុង",
    date: "18-21 កញ្ញា 2021",
    price: 35,
  ),
  PackageModel(
    imagelocation: "assets/activities/kompot/mountain.png",
    total: 40,
    booked: 15,
    title: "ដំណើរកំសាន្តដើរព្រៃនៅកំពត",
    location: "ខេត្តកំពត",
    date: "30-2 តុលា 2021",
    price: 15,
  ),
  PackageModel(
    imagelocation: "assets/activities/kompot/bostong.png",
    total: 25,
    booked: 18,
    title: "ភ្នំបូកគោបោះតង់2ថ្ងៃ1យប់",
    location: "ខេត្តព្រះសីហនុ",
    date: "10-11 តុលា 2021",
    price: 25,
  )
];

/////////////////////////
/// PLACES DATA
List<CardModel> places = [
  CardModel(
    title: "រង្វង់មូលធុរេន",
    location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "place_roundedturen",
  ),
  CardModel(
    title: "ស្ថាបត្យកម្មបារាំងចំណាស់-ភ្នំបូកគោ",
    location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "place_franceachitect",
  ),
  CardModel(
    title: "ឧទ្យានព្រែកចាក",
    location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "place_prekjak",
  ),
];

/////////////////////////
/// ACCOMODATIONS DATA
List<CardModel> accomodations = [
  CardModel(
    title: "Ganesha ផ្ទះសំណាក់អេកូ",
    location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "acc_genesha",
    price: "15\$ - 25\$",
    ratestar: 4.5,
  ),
  CardModel(
    title: "Eden ភូមិអេកូ",
    location: "ជាប់មាត់ព្រែកកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "acc_eden",
    price: "15\$ - 25\$",
    ratestar: 4.5,
  ),
  CardModel(
    title: "Ramo រីសត",
    location: "2.3គីឡូម៉ែត្រពីរង្វង់មូលធូរេន",
    imageLocation: "assets/provinces/kep.png",
    id: "acc_ramo",
    price: "15\$ - 25\$",
    ratestar: 4.5,
  ),
];

/////////////////////////
/// ACTITIVIES DATA
List<CardModel> activities = [
  CardModel(
    title: "ជិះកង់មើលទេសភាពនៅក្នុងតំបន់ទេសចរណ៍",
    location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "act_biking",
    price: "\$3 ក្នុងកង់",
    ratestar: 4.5,
  ),
  CardModel(
    title: "ជិះទូកស្រូបយកខ្យល់បូរិសុទ្ធ",
    location: "4គីឡូម៉ែត្រពីក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "act_boating",
    price: "\$3 ក្នុងម្នាក់",
    ratestar: 4.5,
  ),
];

/////////////////////////
/// ACTITIVIES DATA
List<CardModel> foods = [
  CardModel(
    title: "Epic Arts Cafe",
    location: "កំពង់កណ្ដាល, កំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "res_epicartcafe",
    price: "15\$ - 25\$",
    ratestar: 4.5,
  ),
  CardModel(
    title: "ផ្ទះបៃតង",
    location: "ក្បែរមាត់ព្រែកកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "res_greenhouse",
    price: "15\$ - 25\$",
    ratestar: 4.5,
  ),
  CardModel(
    title: "Tertulia",
    location: "កណ្ដាលក្រុងកំពត",
    imageLocation: "assets/provinces/kep.png",
    id: "res_tertulia",
    price: "15\$ - 25\$",
    ratestar: 4.5,
  ),
];
