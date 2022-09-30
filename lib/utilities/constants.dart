import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final textStyle = GoogleFonts.montserrat(
  fontSize: 15,
  color: Colors.white70,
  fontWeight: FontWeight.w500,
);

final textStyleBlue = GoogleFonts.montserrat(
  fontSize: 15,
  color: Colors.blue,
  fontWeight: FontWeight.w500,
);

final textStyleTitle = GoogleFonts.montserrat(
  color: Colors.white,
  fontSize: 25,
  fontWeight: FontWeight.w600,
);

final labelStyle = GoogleFonts.montserrat(
  fontSize: 15,
  color: Colors.white,
  fontWeight: FontWeight.bold,
);

const labelStyleDark = TextStyle(
  color: Color(0xFF3040a3),
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

const labelStyleHeader = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
  fontSize: 16,
);

final boxDecorationStyle = BoxDecoration(
  color: const Color.fromARGB(139, 48, 63, 163),
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
