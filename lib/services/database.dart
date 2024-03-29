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

  Future deletePreset(int i) async {
    final ref = _database.ref(_user).child(i.toString());
    await ref.set(null);
    debugPrint("Preset Excluido!");
  }

  Future deleted(int count) async {
    List<int> items = [];
    final ref = _database.ref();
    final snapshot = await ref.child(_user!).get();
    if (snapshot.exists) {
      for (int i = 0; i < count; i++) {
        debugPrint(snapshot.child(i.toString()).value.toString());
        if (snapshot.child(i.toString()).value == null) {
          items.add(i.toInt());
        }
      }
    }
    return items;
  }

  /*Future updatePresetIds() async {
    final ref = _database.ref();
    final snapshot = await ref.child(_user!).get();
    final count = await countPresets();
    if (snapshot.exists) {
      List data = snapshot.ref.;
      for (var i = 0; i < count; i++) {
        snapshot.child(i.toString()).
        snapshot.ref.update()
      }
      
    }
  }*/

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
