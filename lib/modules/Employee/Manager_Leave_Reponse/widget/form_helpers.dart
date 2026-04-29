import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

BoxDecoration formBoxDecoration() {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

InputDecoration formInputDecoration({IconData? prefixIcon, String? hint}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: cairoStyle(fontcolor: Colors.grey[400], fontSize: 14),
    prefixIcon: prefixIcon != null
        ? Icon(prefixIcon, color: Appcolors.primarycolor, size: 22)
        : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
  );
}
