import 'package:flutter/material.dart';

const kHintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

const kLabelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const kLabelStyleDark = TextStyle(
  color: Color(0xFF3040a3),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const kLabelStyleHeader = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 16,
);

final kBoxDecorationStyle = BoxDecoration(
  color: const Color.fromARGB(139, 48, 63, 163),
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
