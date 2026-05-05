import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';

void confirmLogout(Function() onLogout) {
  Get.dialog(
    Dialog(
      constraints: const BoxConstraints(maxWidth: 500),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.logout_rounded, color: Colors.red.shade600, size: 60),
            const SizedBox(height: 15),
            Text(
              'تسجيل الخروج',
              style: cairoStyle(fontSize: 20, fontweight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              'هل أنت متأكد من رغبتك في تسجيل الخروج؟ ستضطر لتسجيل الدخول مرة أخرى للوصول إلى بياناتك.',
              textAlign: TextAlign.center,
              style: cairoStyle(fontSize: 14, fontcolor: Colors.grey.shade600),
            ),
            const SizedBox(height: 25),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Get.back(),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'إلغاء',
                      style: cairoStyle(fontSize: 16, fontcolor: Colors.black),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Get.back();
                      onLogout();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade600,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'خروج',
                      style: cairoStyle(
                        fontSize: 16,
                        fontcolor: Colors.white,
                        fontweight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
