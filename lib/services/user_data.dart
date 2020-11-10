import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  final String uid, fname, lname, image, role, email;

  UserData({this.uid, this.fname, this.lname, this.image, this.role, this.email});
}

class UserDatabase {
  final String uid;
  UserDatabase({this.uid});

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection('userData');

  Future updateUserData(String name) async {
    return await userCollection.doc(uid).set({'name': name});
  }

  // user data from snapshot
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
      uid: uid,
      fname: snapshot.data()['fname'] ?? null,
      lname: snapshot.data()['lname'] ?? null,
      image: snapshot.data()['image'] ?? null,
      role: snapshot.data()['role'] ?? "User",
      email: snapshot.data()['email'],
    );
  }

  // get user doc stream
  Stream<UserData> get userData {
    return userCollection.doc(uid).snapshots().map((_userDataFromSnapshot));
  }
}
