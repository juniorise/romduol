import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/models/models.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/validation.dart';
import 'package:romduol/services/write_data.dart';
import 'package:romduol/widget/drop_down.dart';
import 'package:romduol/widget/theme.dart';

class AddToProvince extends StatefulWidget {
  AddToProvince(
      {Key key, @required this.isKH, this.data, this.category, this.province})
      : super(key: key);
  final bool isKH;
  final CardModel data;
  final String category, province;

  @override
  _AddToProvinceState createState() => _AddToProvinceState();
}

class _AddToProvinceState extends State<AddToProvince> {
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
    if (_formKey.currentState.validate()) {
      setState(() => loading = true);
      toNumber();

      data = CardModel(
        title: name != '' ? name.trim() : "No title provided.",
        location: location != '' ? location.trim() : "No location provided.",
        thumbnail: thumbnail != 'no'
            ? thumbnail.trim()
            : 'https://firebasestorage.googleapis.com/v0/b/romduoltravel.appspot.com/o/commons%2Ferror-image-generic.png?alt=media&token=4fdd9d9b-04f6-4228-8b13-cd19a27fd44f',
        id: id.trim() ?? "No id provided.",
        pricefrom: !isPlace ? fpricefrom : 0,
        pricetotal: !isPlace ? fpricetotal : 0,
        maplocation: flatitude != null && flongtitude != null
            ? GeoPoint(flatitude, flongtitude)
            : GeoPoint(0, 0),
        images: images,
        articles: paragraphs,
        comments: widget.data != null ? widget.data.comments : List(),
      );

      try {
        await WriteData().draftToProvince(
          data: data,
          province: selectedProvince,
          category: selectedCategory,
          uid: uid,
        );
      } catch (e) {
        error = e.toString();
      }

      setState(() => loading = false);
    }
  }

  void uploadtoFirebase(String uid, BuildContext context) async {
    if (_formKey.currentState.validate()) {
      savedraft(uid, context);
      await WriteData().uploadToProvince(
        data: data,
        province: selectedProvince.trim(),
        category: selectedCategory.trim(),
        uid: uid.trim(),
      );
    }
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
        title: "Add data to province",
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

class BuildInput extends StatefulWidget {
  const BuildInput({
    Key key,
    @required this.header,
    @required this.hint,
    this.readOnly = false,
    this.suffix,
    @required this.value,
    @required this.onFinished,
    this.validator,
    this.removeEndPadding = false,
    this.isRequestSubmit = false,
  }) : super(key: key);

  final bool removeEndPadding, isRequestSubmit, readOnly;
  final Function onFinished, validator;
  final Widget suffix;
  final String header, hint, value;

  @override
  _BuildInputState createState() => _BuildInputState();
}

class _BuildInputState extends State<BuildInput> {
  TextEditingController _textController;

  @override
  void initState() {
    _textController = TextEditingController(text: widget.value);
    super.initState();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  String _value = "";

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.header != null
            ? Text(
                widget.header,
                style: TextStyle(
                  color: Palette.sky,
                ),
              )
            : SizedBox(),
        SizedBox(height: 5.0),
        Row(
          children: [
            Container(
              width: widget.suffix != null
                  ? MediaQuery.of(context).size.width - 45 - 20 - 5
                  : MediaQuery.of(context).size.width - 45,
              child: Focus(
                onFocusChange: (isFocus) {
                  if (!isFocus) {
                    if (_value.isNotEmpty)
                      widget.onFinished(_value);
                    else
                      widget.onFinished(_textController.value.text);
                  }
                  print(_value);
                },
                child: TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Palette.bggrey.withOpacity(0.2),
                    border: InputBorder.none,
                    hintText: widget.hint,
                    contentPadding: EdgeInsets.fromLTRB(12, 8, 0, 8),
                    hintStyle: TextStyle(fontSize: 13),
                    errorStyle: TextStyle(color: Palette.red),
                  ),
                  textInputAction: TextInputAction.done,
                  minLines: 1,
                  maxLines: 50,
                  style: TextStyle(fontSize: 13),
                  autofocus: false,
                  onChanged: (val) {
                    setState(() {
                      _value = val;
                    });
                    if (!widget.isRequestSubmit) widget.onFinished(val);
                  },
                  validator: (value) {
                    if (value.isEmpty)
                      return "Please insert value";
                    else if (widget.validator != null)
                      return widget.validator(value);
                    return null;
                  },
                  controller: _textController,
                ),
              ),
            ),
            widget.suffix != null ? SizedBox(width: 5.0) : SizedBox(),
            widget.suffix != null
                ? Container(width: 20, child: widget.suffix)
                : SizedBox(),
          ],
        ),
        SizedBox(height: widget.removeEndPadding ? 0 : 12.0)
      ],
    );
  }
}
