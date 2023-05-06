import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormat {
   headerText({String? text, Color? colors}) {
    return Text(
      text!,
      style: GoogleFonts.poppins(
          fontSize: 16, fontWeight: FontWeight.bold, color: colors),
    );
  }

  defaultText(String? text, Color? colors){
     return Text(
      text!,
      style: GoogleFonts.poppins(
          fontSize: 14, fontWeight: FontWeight.bold, color: colors),
    );
  }

}
