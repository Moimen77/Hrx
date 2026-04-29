// ignore_for_file: file_names

import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

TextStyle cairoStyle({
  double? fontSize,
  FontWeight? fontweight,
  Color? fontcolor,
  double? height,
  TextDecoration? decoration,
  double? letterSpacing,
}) {
  return GoogleFonts.cairo(
    decoration: decoration ?? TextDecoration.none,
    fontSize: fontSize ?? 16,
    fontWeight: fontweight ?? FontWeight.normal,
    color: fontcolor ?? Colors.black,
    height: height ?? 1.5,
    letterSpacing: letterSpacing ?? 0.5,
  );
}
