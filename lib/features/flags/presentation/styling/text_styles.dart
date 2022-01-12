import 'package:flags_task/features/flags/presentation/styling/color_palettes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextStyle buildRegionCardTextStyle() {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
    color: highlight,
    fontSize: 36,
    fontWeight: FontWeight.w400,
  ));
}

TextStyle buildHeadingCardTextStyle() {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
    color: highlight,
    fontSize: 32,
    fontWeight: FontWeight.bold,
  ));
}
