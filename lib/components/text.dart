import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFormat {
  headerText({String? text, Color? colors}) {
    return Text(
      text!,
      style: GoogleFonts.montserrat(
          fontSize: 20, fontWeight: FontWeight.bold, color: colors),
    );
  }

  defaultText(String? text, Color? colors) {
    return Text(
      text!,
      style: GoogleFonts.montserrat(
          fontSize: 14, fontWeight: FontWeight.bold, color: colors),
    );
  }
}
