import 'package:flutter/material.dart';
import 'package:romduol/screens/admin/add_to_province.dart';
import 'package:romduol/widget/theme.dart';

class AdminWhyTourPackage extends StatefulWidget {
  const AdminWhyTourPackage({Key key}) : super(key: key);

  @override
  _AdminWhyTourPackageState createState() => _AdminWhyTourPackageState();
}

class _AdminWhyTourPackageState extends State<AdminWhyTourPackage> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: buildAppBar(title: "Why tour package", isKH: false),
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
                          header: "Title",
                          hint: "eg. អេកូ-កញ្ចប់ដំណើរកំសាន្ត",
                          onFinished: (val) => setState(() {}),
                          value: null,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
