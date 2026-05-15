import 'package:flutter/material.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

BoxDecoration formBoxDecoration(BuildContext context) {
  return BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(12.spAdaptive(context)),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.03),
        blurRadius: 6,
        offset: const Offset(0, 2),
      ),
    ],
  );
}

InputDecoration formInputDecoration({
  required BuildContext context,
  IconData? prefixIcon,
  String? hint,
}) {
  return InputDecoration(
    hintText: hint,
    hintStyle: cairoStyle(
      fontcolor: Colors.grey[400],
      fontSize: 14.spAdaptive(context),
    ),
    prefixIcon: prefixIcon != null
        ? Icon(
            prefixIcon,
            color: Appcolors.primarycolor,
            size: 22.spAdaptive(context),
          )
        : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.spAdaptive(context)),
      borderSide: BorderSide.none,
    ),
    filled: true,
    fillColor: Colors.white,
    contentPadding: EdgeInsets.symmetric(
      horizontal: 12.spAdaptive(context),
      vertical: 14.spAdaptive(context),
    ),
  );
}
