import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rac/main.dart';
import 'package:rac/utilities/messages.dart';

class ResetPassword {
  final _auth = FirebaseAuth.instance;

  Future sendEmail(context, email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      messageToUser(context, "Email enviado! Verifique a caixa de Spam.", 1);
      debugPrint("Sended email!");
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } on FirebaseAuthException {
      messageToUser(
          context, "Email inválido! Cadastre-se ou tente novamente!", 2);
      debugPrint("Invalid email!");
    }
  }
}
