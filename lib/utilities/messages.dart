import 'package:flutter/material.dart';
import 'package:rac/utilities/constants.dart';

Future messageToUser(context, text, type) async {
  switch (type) {
    case 1:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text, style: labelStyle),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(255, 58, 150, 16),
      ));
      break;
    case 2:
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(text, style: labelStyle),
        duration: const Duration(seconds: 3),
        backgroundColor: const Color.fromARGB(255, 187, 24, 12),
      ));
      break;
  }
}
