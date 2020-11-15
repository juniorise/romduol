import 'package:flutter/material.dart';
import 'package:romduol/configs/palette.dart';
import 'package:romduol/screens/admin/add_to_province.dart';
import 'package:romduol/services/auth.dart';
import 'package:romduol/services/validation.dart';
import 'package:romduol/widget/theme.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({Key key, @required this.isKH}) : super(key: key);
  final bool isKH;
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String email = '', password = '', error = '';
  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();

  bool loading = false;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: buildAppBar(title: "Login", isKH: widget.isKH),
      body: loading
          ? Container(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                heightFactor: 1,
                child: Container(
                  width: 30,
                  height: 30,
                  child: CircularProgressIndicator(),
                ),
              ),
            )
          : Form(
              key: _formKey,
              child: Column(
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
                          header: "Email",
                          hint: "eg. info@example.com",
                          onFinished: (val) => setState(() => email = val),
                          value: email,
                          validator: (value) {
                            return Validation().validateEmail(value);
                          },
                        ),
                        BuildInput(
                          header: "Password",
                          hint: "********",
                          onFinished: (val) => setState(() => password = val),
                          value: password,
                          removeEndPadding: true,
                          validator: (value) {
                            return Validation().validatePassword(value);
                          },
                        ),
                        SizedBox(height: 12),
                        Container(
                          height: 50,
                          width: width,
                          margin: EdgeInsets.only(left: 20, right: 20),
                          decoration: buildBoxDecoration().copyWith(
                            borderRadius: BorderRadius.circular(5),
                            color: Palette.sky,
                          ),
                          child: FlatButton(
                            splashColor: Colors.transparent,
                            onPressed: () async {
                              print(email + password);
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                dynamic result =
                                    await _auth.signInWithEmailPassword(
                                  email,
                                  password,
                                );

                                if (result == null) {
                                  setState(() {
                                    loading = false;
                                    error =
                                        'Could not sign in with those credentials!';
                                  });
                                } else if (result != null) {
                                  print("Here is result" + result.toString());
                                  Navigator.pop(context);
                                }
                              }
                            },
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5)),
                            child: Text(
                              "Login",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w300),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    '$error',
                    style: TextStyle(color: Palette.red, fontSize: 14),
                  )
                ],
              ),
            ),
    );
  }
}
