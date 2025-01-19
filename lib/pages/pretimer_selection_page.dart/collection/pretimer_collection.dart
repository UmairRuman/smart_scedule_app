import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_club_app/pages/pretimer_selection_page.dart/model/pretimer.dart';

class PretimerCollection {
  static final PretimerCollection instance = PretimerCollection._internal();

  PretimerCollection._internal();
  final CollectionReference pretimerCollection =
      FirebaseFirestore.instance.collection('Pretimers');

  factory PretimerCollection() {
    return instance;
  }

  Future<bool> addPretimer(Pretimer pretimer) async {
    try {
      await pretimerCollection.doc(pretimer.pretimerId).set(pretimer.toMap());
      log("Pretimer added successfully: ${pretimer.pretimerId}");
      return true;
    } catch (e) {
      log("Error adding pretimer: $e");
      return false;
    }
  }

  Future<bool> updatePretimer(Pretimer pretimer) async {
    try {
      await pretimerCollection
          .doc(pretimer.pretimerId)
          .update(pretimer.toMap());
      log("Pretimer updated successfully: ${pretimer.pretimerId}");
      return true;
    } catch (e) {
      log("Error updating pretimer: $e");
      return false;
    }
  }

  Future<bool> deletePretimer(String pretimerId) async {
    try {
      await pretimerCollection.doc(pretimerId).delete();
      log("Pretimer deleted successfully: $pretimerId");
      return true;
    } catch (e) {
      log("Error deleting pretimer: $e");
      return false;
    }
  }

  Future<Pretimer?> getPretimer(String pretimerId) async {
    try {
      DocumentSnapshot snapshot =
          await pretimerCollection.doc(pretimerId).get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return Pretimer.fromMap(data);
      } else {
        log("Pretimer not found: $pretimerId");
        return null;
      }
    } catch (e) {
      log("Error getting pretimer: $e");
      return null;
    }
  }

  Future<List<Pretimer>> getAllPretimers() async {
    List<Pretimer> pretimers = [];
    try {
      QuerySnapshot snapshot = await pretimerCollection.get();
      for (var doc in snapshot.docs) {
        pretimers.add(Pretimer.fromMap(doc.data() as Map<String, dynamic>));
      }
      log("Total pretimers fetched: ${pretimers.length}");
      return pretimers;
    } catch (e) {
      log("Error getting all pretimers: $e");
      return [];
    }
  }

  Future<List<Pretimer>> getPretimersByDuration(int duration) async {
    List<Pretimer> pretimers = [];
    try {
      QuerySnapshot snapshot = await pretimerCollection
          .where('pretimerDuration', isEqualTo: duration)
          .get();
      for (var doc in snapshot.docs) {
        pretimers.add(Pretimer.fromMap(doc.data() as Map<String, dynamic>));
      }
      log("Pretimers with duration $duration fetched: ${pretimers.length}");
      return pretimers;
    } catch (e) {
      log("Error getting pretimers by duration: $e");
      return [];
    }
  }
}
