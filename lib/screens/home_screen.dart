import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rac/services/google_auth.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Home"),
        actions: <Widget>[
          TextButton(
            child: const Text('Logout',
                style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () {
              FirebaseAuth.instance.signOut();
              //final provider = Provider.of<GoogleSignInProvider>(context, listen: false);
              //provider.googleLogOut();
            },
          )
        ],
      ),
      body: const Center(
          child: Text('Tela Principal', style: TextStyle(fontSize: 32.0))),
    );
  }
}
