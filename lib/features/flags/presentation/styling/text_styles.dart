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
    fontSize: 28,
    fontWeight: FontWeight.bold,
  ));
}

TextStyle buildTileHeadingTextStyle() {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: secondary, fontSize: 18, fontWeight: FontWeight.w600));
}

TextStyle buildTileNormalTextStyle() {
  return GoogleFonts.notoSans(
      textStyle: const TextStyle(
    color: Colors.black,
    fontSize: 14,
  ));
}

TextStyle buildLanguageTextStyle() {
  return GoogleFonts.notoSans(
    textStyle:
        TextStyle(color: highlight, fontSize: 20, fontWeight: FontWeight.w600),
  );
}

TextStyle buildErrorCardStyle() {
  return GoogleFonts.notoSans(
      textStyle: TextStyle(
          color: highlight, fontSize: 18.0, fontWeight: FontWeight.w600));
}
