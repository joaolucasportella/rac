import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:rac/services/authentication.dart';

class Database {
  final _database = FirebaseDatabase.instance;
  final _user = Authentication.auth.currentUser?.uid;

  Future setPresets(int i, List array) async {
    final ref = _database.ref(_user).child(i.toString());
    await ref.set(array);
    debugPrint("Preset added!");
  }

  Future getPresets(int i) async {
    final ref = _database.ref();
    final snapshot = await ref.child(_user!).get();
    if (snapshot.exists) {
      debugPrint(snapshot.child(i.toString()).value.toString());
    } else {
      debugPrint("No data available.");
    }
  }

  Future<int> countPresets() async {
    final ref = _database.ref();
    final snapshot = await ref.child(_user!).get();
    int count = 0;
    if (snapshot.exists) {
      count = snapshot.children.length;
      debugPrint("Presets available: " + count.toString());
      return count;
    } else {
      debugPrint("No presets available.");
      return count;
    }
  }
}
