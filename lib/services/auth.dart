import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class CustomUser {
  final String uid;
  CustomUser({this.uid});
}

class AuthService {
  final instance = FirebaseAuth.instance;
  String userEmail;

  Future<CustomUser> signInAnon() async {
    try {
      UserCredential res = await instance.signInAnonymously();
      User user = res.user;
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  CustomUser _userFromFirebase(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }
}
