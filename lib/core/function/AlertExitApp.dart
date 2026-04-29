import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

void showExitDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Center(
        child: Text(
          "تنبيه",
          style: cairoStyle(
            fontcolor: Colors.black,
            fontSize: 20,
            fontweight: FontWeight.bold,
          ),
        ),
      ),
      content: Text(
        "هل تريد الخروج من التطبيق؟",
        style: cairoStyle(
          fontcolor: Colors.grey.shade700,
          fontSize: 16,
          fontweight: FontWeight.normal,
        ),
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.grey.shade300,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            "إلغاء",
            style: cairoStyle(
              fontcolor: Colors.black87,
              fontSize: 16,
              fontweight: FontWeight.w600,
            ),
          ),
        ),

        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          ),
          onPressed: () {
            exit(0);
          },
          child: Text(
            "خروج",
            style: cairoStyle(
              fontcolor: Colors.white,
              fontSize: 16,
              fontweight: FontWeight.w600,
            ),
          ),
        ),
      ],
    ),
  );
}
