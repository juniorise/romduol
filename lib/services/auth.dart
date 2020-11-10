import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';
import 'user_data.dart';

class CustomUser {
  final String uid;
  CustomUser({this.uid});
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  String userEmail;

  // create user object based on FirebaseUser
  CustomUser _userFromFirebaseUser(User user) {
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // auth change user stream
  Stream<CustomUser> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
    //.map((User user) => _userFromFirebaseUser(user));  // this is same to above
  }

  // sign in with email and password
  Future<CustomUser> signInWithEmailPassword(
      String email, String password) async {
    try {
      UserCredential res = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("SIGN IN WITH EMAIL " + e.toString());
      return null;
    }
  }

  // sign in anon
  Future<CustomUser> signInAnon() async {
    try {
      UserCredential res = await _auth.signInAnonymously();
      User user = res.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print("SIGN IN ANON " + e.toString());
      return null;
    }
  }

  //register
  Future registerWithEmailAndPasswrod(String email, String password, String name) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: email,
      );
      User user = result.user;

      // create a new document for user with uid
      await UserDatabase(uid: user.uid).updateUserData("");

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      print('registering error!');
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
      print('signing out error');
      return null;
    }
  }
}
