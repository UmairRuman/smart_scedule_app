//Function For getting Admin key
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

Future<String> getAdminKey() async {
  String collectionName = "Admin Key";
  String documentId = "accessKey";
  var snapshot = await FirebaseFirestore.instance
      .collection(collectionName)
      .doc(documentId)
      .get();

  String value = await snapshot.data()!.entries.first.value;
  return value;
}
