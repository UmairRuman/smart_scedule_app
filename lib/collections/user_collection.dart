import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class UserCollection {
  static final UserCollection instance = UserCollection._internal();
  UserCollection._internal();
  static var userCollection =
      FirebaseFirestore.instance.collection('User Collection');

  factory UserCollection() {
    return instance;
  }

  Future<bool> addUser() async {
    try {
      await userCollection.doc("Macha Dev").set({"userName": "Macha Dev"});
      return true;
    } catch (e) {
      log("Error adding user: $e");
      return false;
    }
  }
}
