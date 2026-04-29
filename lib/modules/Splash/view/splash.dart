import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hrx/modules/Splash/Controller/splash_controller.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(SplashController());

    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // دائرة بالأيقونة
            Container(
              padding: const EdgeInsets.all(25),
              decoration: BoxDecoration(
                color: const Color(0xFFe8f1ff),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.people_alt_outlined,
                size: 70,
                color: Color(0xFF2D74FF),
              ),
            ),

            const SizedBox(height: 20),

            // اسم النظام
            Text(
              "نظام إدارة الموارد البشرية",
              style: GoogleFonts.cairo(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "HR Management System",
              style: GoogleFonts.cairo(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
