import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rac/main.dart';
import 'package:rac/utilities/messages.dart';

class Authentication {
  static final auth = FirebaseAuth.instance;
  static final googleSignIn = GoogleSignIn();
  static bool _loggedWithGoogle = false;

  String getCurrentUser() {
    return auth.currentUser.toString();
  }

  Future signUp(context, email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _loggedWithGoogle = false;
      messageToUser(context, "Cadastrado! Bem-vindo!", 1);
      debugPrint("Registered user!");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      messageToUser(context, "Email inválido! Tente novamente!", 2);
      debugPrint(e.toString());
    }
  }

  Future signIn(context, email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      _loggedWithGoogle = false;
      messageToUser(context, "Bem-vindo!", 1);
      debugPrint("User logged in!");
    } on FirebaseAuthException catch (e) {
      messageToUser(context,
          "Email ou Senha inválidos! Tente novamente ou cadastre-se!", 2);
      debugPrint(e.toString());
    }
  }

  Future googleLogIn(context) async {
    try {
      var googleUser = await googleSignIn.signIn();
      debugPrint(googleUser.toString());
      if (googleUser == null) return;

      final googleAuth = await googleUser.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      await auth.signInWithCredential(credential);
      _loggedWithGoogle = true;
      messageToUser(context, "Bem-vindo!", 1);
    } catch (e) {
      messageToUser(context, "Algo deu errado! Tente novamente!", 1);
      debugPrint(e.toString());
    }
  }

  Future signOut() async {
    if (_loggedWithGoogle) {
      await googleSignIn.disconnect();
    }
    await auth.signOut();
    debugPrint("User logged out!");
  }
}
