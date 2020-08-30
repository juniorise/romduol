import 'package:romduol/screens/screens.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

List<Places> places = [
  Places(
    title: "ឧទ្យានជាតិព្រះមុនីវង្សបូកគោ",
    descibe: "ទីតាំងស្ថិតនៅក្នុងខេត្តកំពត",
    path: "assets/places/boko.png",
    isPopular: true,
  ),
  Places(
    title: "ទឹកជ្រោះតាតៃ",
    descibe: "ទីតាំងស្ថិតនៅក្នុងខេត្តកោះកុង",
    path: "assets/places/waterfall.png",
    isPopular: true,
  )
];

class Places {
  String title, descibe, path;
  bool isPopular;
  Places(
      {@required this.title,
      @required this.descibe,
      @required this.path,
      this.isPopular});
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          children: <Widget>[
            SizedBox(
              height: 190,
              child: Stack(
                children: <Widget>[
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                      child: Image.asset(
                        'assets/home/header.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: Palette.greenyellow,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 16,
                    child: Container(
                      width: 70,
                      child: Image.asset(
                        'assets/graphics/romduol.png',
                        fit: BoxFit.fitHeight,
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(25),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          SizedBox(height: 30),
                          Text(
                            "សួរស្តី​ Sok",
                            style: TextStyle(
                              color: Palette.background,
                              fontSize: 22,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          Text(
                            "តើអ្នកចង់ទៅដំណើរកំសាន្តឯណាដែរ?",
                            style: TextStyle(
                              color: Palette.background,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        color: Colors.white,
                        icon: FaIcon(FontAwesomeIcons.alignLeft),
                        onPressed: () {},
                      ),
                      IconButton(
                        color: Colors.white,
                        icon: FaIcon(FontAwesomeIcons.bell),
                        onPressed: () {},
                      )
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            ThreeLayerCard(
              title: 'អេកូ-កញ្ចប់ដំណើរកំសាន្ត',
              describe:
                  'ដំណើរកំសាន្តប្រកបដោយចីរភាព សន្សំសច្ចៃ និង មានសុវត្តិភាព',
              onPressed: () {},
              path: 'assets/provinces/kompot.png',
            ),
            SizedBox(height: 12),
            HeaderText(headerText: "ទីតាំងពេញនិយម"),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: places.length,
                itemBuilder: (context, index) {
                  Places place = places[index];
                  return ThreeLayerCard(
                    title: place.title,
                    describe: place.descibe,
                    onPressed: () {},
                    path: place.path,
                  );
                },
              ),
            ),
            SizedBox(height: 12),
            HeaderText(headerText: "ខេត្ត"),
            Container(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  return ThreeLayerCard(
                    title: 'អេកូ-កញ្ចប់ដំណើរកំសាន្ត',
                    describe:
                        'ដំណើរកំសាន្តប្រកបដោយចីរភាព សន្សំសច្ចៃ និង មានសុវត្តិភាព',
                    onPressed: () {},
                    path: 'assets/provinces/kompot.png',
                  );
                },
              ),
            ),
            SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
