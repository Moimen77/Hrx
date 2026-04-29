import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrx/core/appColors.dart';

void showErrorDialog(
  BuildContext context,
  String message, [
  bool iserror = true,
]) {
  Get.defaultDialog(
    title: "",
    titleStyle: const TextStyle(fontSize: 0),
    radius: 20,
    backgroundColor: Colors.white,
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // أيقونة تحذير
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Appcolors.primarycolor.withOpacity(0.15), // أزرق فاتح
          ),
          child: Icon(
            iserror
                ? Icons.error_outline_rounded
                : Icons.check_circle_outline_rounded,
            color: Appcolors.primarycolor, // الأزرق الأساسي
            size: 55,
          ),
        ),

        const SizedBox(height: 16),

        // العنوان
        Text(
          iserror ? "حدث خطأ" : "تمت العملية بنجاح",
          style: GoogleFonts.cairo(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Appcolors.primarycolor,
          ),
        ),

        const SizedBox(height: 8),

        // الرسالة
        Text(
          message,
          textAlign: TextAlign.center,
          style: GoogleFonts.cairo(fontSize: 15, color: Colors.grey.shade800),
        ),

        const SizedBox(height: 22),

        // زر الإغلاق
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.primarycolor,
              padding: const EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
            ),
            onPressed: () => Get.back(),
            child: Text(
              "إغلاق",
              style: GoogleFonts.cairo(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
