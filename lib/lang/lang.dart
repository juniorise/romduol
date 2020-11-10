import 'package:shared_preferences/shared_preferences.dart';

class Lang {
  Map<String, String> kh = {
    'hello': 'សួស្តី​',
    'title': "រំដួល",
    'changelang': "ផ្លាស់ប្តូរជាភាសាអង់គ្លេស",
    'setting': "ការកំណត់",
    'contactus': "ទាក់ទង់ពួកយើង",
    'reportissue': "កម្មវិធីមានបញ្ហា",
    'exitapp': "ចាកចេញ",
    'views': 'នាក់បានចូលមើល',
    'moreinfo': "ព័ត៏មានបន្ថែម",
    'posterpackageinfo':
        'ដំណើរកំសាន្តប្រកបដោយចីរភាព សន្សំសច្ចៃ និង មានសុវត្តិភាព',
    'ecotravelpackage': 'អេកូ-កញ្ចប់ដំណើរកំសាន្ត',
    'chooseaprovince': 'សូមជ្រើសរើសខេត្តណាមួយនៃតំបន់ឆ្នេរ',
    'joinwithus': 'ចូលរួមជាមួយពួកយើង',
    'doyouwantexitapp': 'តើអ្នកចង់ចាក់ចេញពីកម្មវិធីមែនទេ?',
    'place': 'ទីកន្លែង',
    'accomodation': 'កន្លែងស្នាក់នៅ',
    'activities': 'សកម្មភាព',
    'restaurant': 'អាហារ',
    'bookingheader': "សូមបំពេញព័ត៏មានដើម្បីកក់",
    'restuarantexpire': "ការកក់នឹងត្រូវបានផុតកំណត់ក្នុងរយ:ពេល ២ម៉ោង",
    'confirm': "បញ្ជាក់",
    'draft': "ព្រាង", 
    'addinfo': "បន្ថែមទិន្នន័យ"
  };

  Map<String, String> en = {
    'hello': 'Hello',
    'title': "Romduol",
    'changelang': "Change to Khmer language",
    'setting': "Settings",
    'contactus': "Contact Us",
    'reportissue': "Report issues",
    'exitapp': "Exit app",
    'views': 'views',
    'moreinfo': "More info",
    'posterpackageinfo': "Sustainable, economical and safe travel",
    'ecotravelpackage': 'Eco-Travel Package',
    'chooseaprovince': 'Please choose a province',
    'joinwithus': 'Join with us',
    'doyouwantexitapp': 'Do you want to exit the app?',
    'place': 'Places',
    'accomodation': 'Accomodation',
    'activities': 'Activities',
    'restaurant': 'Restaurant',
    'bookingheader': "Please fill the form to book",
    'restuarantexpire': "Booking will be expired within 2 hours from booking",
    'confirm': "Confirm",
    'draft': "Draft", 
    'addinfo': 'Add data'
  };

  String of({String key, bool isKH = true}) {
    if (isKH)
      return kh[key];
    else
      return en[key];
  }

  void setLang(bool isKH) async {
    SharedPreferences _sharedPreferences =
        await SharedPreferences.getInstance();
    await _sharedPreferences.setBool('isKH', isKH);
  }

  Future<bool> isKH() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isKH') ?? true;
  }
}
