import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/screens/admin/add_to_province.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/validation.dart';
import 'package:romduol/widget/drop_down.dart';
import 'package:romduol/widget/theme.dart';

class AddPackage extends StatefulWidget {
  AddPackage(
      {Key key, @required this.isKH, this.data, this.category, this.province})
      : super(key: key);
  final bool isKH;
  final CardModel data;
  final String category, province;

  @override
  _AddPackageState createState() => _AddPackageState();
}

class _AddPackageState extends State<AddPackage> {
  List<String> provinces = [
    'keb',
    'kohkong',
    'kompot',
    'preahsihanouk',
  ];
  List<String> categories = [
    'accomodations',
    'activities',
    'places',
    'restaurants'
  ];

  String error = '';
  Color background = Palette.bg;
  var name,
      id,
      thumbnail,
      location,
      latitude,
      longtitude,
      pricefrom,
      pricetotal,
      ratetotal,
      rating;

  var flatitude, flongtitude, fpricefrom, fpricetotal;

  List<dynamic> images = [''];
  List<dynamic> paragraphs = [''];

  String selectedProvince = "keb", selectedCategory = "accomodations";

  bool get isPlace => selectedCategory == "places";
  bool get isInit => widget.data == null;
  bool loading = false, isExist = false;
  final _formKey = GlobalKey<FormState>();

  void toNumber() {
    if (flatitude != null && flongtitude != null) {
      try {
        flatitude = double.parse(latitude.trim());
        flongtitude = double.parse(longtitude.trim());
      } catch (e) {}

      print("$flatitude, $flongtitude");
    }
    if (!isPlace) {
      try {
        fpricefrom = double.parse(pricefrom.trim());
        fpricetotal = double.parse(pricetotal.trim());
      } catch (e) {}
    }
  }

  CardModel data;
  void savedraft(String uid, BuildContext context) async {
    if (_formKey.currentState.validate()) {}
  }

  void uploadtoFirebase(String uid, BuildContext context) async {
    if (_formKey.currentState.validate()) {}
  }

  @override
  void initState() {
    if (widget.data != null) {
      name = widget.data.title.toString();
      id = widget.data.id.toString();
      thumbnail = widget.data.thumbnail.toString();
      location = widget.data.location.toString();
      latitude = widget.data.maplocation.latitude.toString();
      longtitude = widget.data.maplocation.longitude.toString();
      pricefrom = widget.data.pricefrom.toString();
      pricetotal = widget.data.pricetotal.toString();
      ratetotal = widget.data.ratetotal.toString();
      rating = widget.data.ratingaverage.toString();
      images = widget.data.images ?? [''];
      paragraphs = widget.data.articles ?? [''];
      selectedProvince = widget.province.toString() ?? "keb";
      selectedCategory = widget.category.toString() ?? "places";

      if (widget.province == null || widget.category == null) {
        print(widget.data.refpath);
        for (int i = 0; i < provinces.length; i++) {
          if (widget.data.refpath.contains(provinces[i]))
            selectedProvince = provinces[i];
        }

        for (int i = 0; i < categories.length; i++) {
          if (widget.data.refpath.contains(categories[i]))
            selectedCategory = categories[i];
        }
      }
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<CustomUser>(context);

    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: background,
      appBar: buildAppBar(
        title: "Add package",
        isKH: widget.isKH,
      ),
      body: loading
          ? Center(
              heightFactor: MediaQuery.of(context).size.height - 48,
              child: Container(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(),
              ),
            )
          : Form(
              key: _formKey,
              child: ListView(
                children: [
                  !isInit
                      ? Container(
                          decoration:
                              buildBoxDecoration().copyWith(color: Palette.sky),
                          margin: EdgeInsets.only(top: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Text(
                            "Data is uploaded to Firebase - id, province, and category can't be changed",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),

                  error != ''
                      ? Container(
                          decoration:
                              buildBoxDecoration().copyWith(color: Palette.sky),
                          margin: EdgeInsets.only(top: 10),
                          padding:
                              EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                          child: Text(
                            error,
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),

                  //SECTION #1
                  Container(
                    width: width,
                    decoration: buildBoxDecoration(),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildInput(
                          header: "Name (title)",
                          hint: "eg. Epic Arts Cafe",
                          onFinished: (val) => setState(() => name = val),
                          value: name,
                        ),
                        IgnorePointer(
                          ignoring: !isInit,
                          child: BuildDropdown(
                            header: isInit
                                ? "Province can't be changed next time"
                                : "Province can't be changed",
                            items: provinces,
                            onChanged: (value) {
                              setState(() => selectedProvince = value);
                              print(selectedProvince);
                            },
                            val: selectedProvince,
                          ),
                        ),
                        IgnorePointer(
                          ignoring: !isInit,
                          child: BuildDropdown(
                            header: isInit
                                ? "Category can't be changed next time"
                                : "Category can't be changed",
                            items: categories,
                            onChanged: (value) {
                              setState(() => selectedCategory = value);
                              print(selectedCategory);
                            },
                            val: selectedCategory,
                          ),
                        ),
                        IgnorePointer(
                          ignoring: !isInit,
                          child: BuildInput(
                            header: isInit
                                ? "ID (id) must be unique & cannot change"
                                : "ID can't be changed",
                            hint: "",
                            onFinished: (val) => setState(() => id = val),
                            value: id,
                          ),
                        ),
                        IgnorePointer(
                          ignoring: true,
                          child: BuildInput(
                            header: null,
                            hint:
                                "Define a new ID to avoid future errors: \nFor restaurant, place & accomodation:\nExample:\n✓ res_genesha (Restaurant)\n✓ place_turen (Place)\n✓ acc_eden (Accomdodation)\n\nFor biking must include 'act_biking':\nExample:\n✓ act_biking_at_beach\n\nFor biking must include 'act_boating':\nEample:\n✓ act_boating_to_kohrong",
                            onFinished: () {},
                            value:
                                "Define a new ID to avoid future errors: \nFor restaurant, place & accomodation:\nExample:\n✓ res_genesha (Restaurant)\n✓ place_turen (Place)\n✓ acc_eden (Accomdodation)\n\nFor biking must include 'act_biking':\nExample:\n✓ act_biking_at_beach\n\nFor biking must include 'act_boating':\nEample:\n✓ act_boating_to_kohrong",
                          ),
                        ),
                        BuildInput(
                          header: "Thumbnail (thumbnail)",
                          hint:
                              "Put image link here - eg. https://example.com/test.png",
                          onFinished: (val) => setState(() => thumbnail = val),
                          value: thumbnail,
                        ),
                      ],
                    ),
                  ),

                  //SECTION #2
                  SizedBox(height: 10),
                  Container(
                    width: width,
                    decoration: buildBoxDecoration(),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        BuildInput(
                          header: "Location (location)",
                          hint: "eg. ជាប់មាត់ព្រែកកំពត",
                          onFinished: (val) => setState(() => location = val),
                          value: location,
                        ),
                        BuildInput(
                          header: "Latitude, Longtitude (maplocation)",
                          hint: "Latitude from -90 to 90",
                          onFinished: (val) => setState(() => latitude = val),
                          value: latitude,
                          validator: (e) {
                            return Validation().isNumeric(e);
                          },
                        ),
                        BuildInput(
                          header: null,
                          hint: "Longitude from -180 to 180",
                          onFinished: (val) => setState(() => longtitude = val),
                          value: longtitude,
                          validator: (e) {
                            return Validation().isNumeric(e);
                          },
                        ),
                      ],
                    ),
                  ),

                  //SECTION #3
                  !isPlace
                      ? Column(
                          children: [
                            SizedBox(height: 10),
                            Container(
                              width: width,
                              decoration: buildBoxDecoration(),
                              padding: EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  BuildInput(
                                    header:
                                        "Price eg. 15\$ - 30\$ (only put number)",
                                    hint: "From",
                                    onFinished: (val) =>
                                        setState(() => pricefrom = val),
                                    value: pricefrom != null
                                        ? pricefrom.toString()
                                        : "",
                                    validator: (e) {
                                      return Validation().isNumeric(e);
                                    },
                                  ),
                                  BuildInput(
                                    header: null,
                                    hint: "Total",
                                    onFinished: (val) =>
                                        setState(() => pricetotal = val),
                                    value: pricetotal != null
                                        ? pricetotal.toString()
                                        : "",
                                    validator: (e) {
                                      return Validation().isNumeric(e);
                                    },
                                  ),
                                ],
                              ),
                            )
                          ],
                        )
                      : SizedBox(),

                  //SECTION #5
                  SizedBox(height: 10),
                  Container(
                    width: width,
                    decoration: buildBoxDecoration(),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Images (click ✔️ on keyboard to save)",
                          style: TextStyle(
                            color: Palette.sky,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        for (int i = 0; i < images.length; i++)
                          BuildInput(
                            key: ObjectKey(images[i]),
                            header: null,
                            hint: "Put image link here",
                            onFinished: (val) =>
                                setState(() => images[i] = val),
                            value: images[i],
                            isRequestSubmit: true,
                            suffix: GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Palette.red,
                              ),
                              onTap: () {
                                if (images.length >= 2) {
                                  setState(() {
                                    images.removeAt(i);
                                  });
                                }
                              },
                            ),
                          ),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.add_rounded,
                            color: Palette.sky,
                          ),
                          label: Text(
                            "Add new image",
                            style: TextStyle(color: Palette.sky),
                          ),
                          onPressed: () {
                            if (images.length < 10) {
                              setState(() {
                                images.add("");
                              });
                            }
                          },
                        ),
                      ],
                    ),
                  ),

                  //SECTION #6
                  SizedBox(height: 10),
                  Container(
                    width: width,
                    decoration: buildBoxDecoration(),
                    padding: EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Paragraph (click ✔️ on keyboard to save)",
                          style: TextStyle(
                            color: Palette.sky,
                          ),
                        ),
                        SizedBox(height: 5.0),
                        for (int i = 0; i < paragraphs.length; i++)
                          BuildInput(
                            key: ObjectKey(paragraphs[i]),
                            header: null,
                            hint: "Write paragraph...",
                            value: paragraphs[i],
                            suffix: GestureDetector(
                              child: Icon(
                                Icons.delete,
                                color: Palette.red,
                              ),
                              onTap: () {
                                if (paragraphs.length >= 2) {
                                  setState(() {
                                    paragraphs.removeAt(i);
                                  });
                                }
                              },
                            ),
                            isRequestSubmit: true,
                            onFinished: (val) => setState(() {
                              paragraphs[i] = val;
                              print(paragraphs[i]);
                            }),
                          ),
                        FlatButton.icon(
                          icon: Icon(
                            Icons.add_rounded,
                            color: Palette.sky,
                          ),
                          label: Text(
                            "Add a paragraph",
                            style: TextStyle(color: Palette.sky),
                          ),
                          onPressed: () {
                            setState(() => paragraphs.add(""));
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    margin: EdgeInsets.only(left: 20, right: 20),
                    child: Row(
                      children: [
                        buildButton(
                          width: width,
                          label: "Save draft",
                          onPressed: () => savedraft(user.uid, context),
                        ),
                        SizedBox(width: 10),
                        buildButton(
                          width: width,
                          label: "Upload",
                          onPressed: () {
                            uploadtoFirebase(user.uid, context);
                          },
                          isUpload: true,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
    );
  }

  Container buildButton({
    double width,
    String label,
    Function onPressed,
    bool isUpload = false,
  }) {
    return Container(
      height: 50,
      width: width / 2 - 20 - 5,
      decoration: buildBoxDecoration().copyWith(
        borderRadius: BorderRadius.circular(5),
        color: isUpload ? Palette.sky : Palette.red,
      ),
      child: FlatButton(
        splashColor: Colors.transparent,
        onPressed: onPressed,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        child: Text(
          label,
          style: TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
