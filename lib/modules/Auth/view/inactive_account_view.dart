import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/routes/app_pages.dart';

class InactiveAccountView extends StatelessWidget {
  const InactiveAccountView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.account_circle_outlined,
                size: 100,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 20),
              Text(
                'الحساب غير متاح',
                style: cairoStyle(
                  fontSize: 24,
                  fontweight: FontWeight.bold,
                  fontcolor: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'عذراً، حسابك غير نشط حالياً. يرجى مراجعة إدارة الموارد البشرية.',
                textAlign: TextAlign.center,
                style: cairoStyle(fontSize: 16, fontcolor: Colors.grey),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Myservices myservices = Get.find();
                    myservices.sharedPref.clear();
                    myservices.sharedPref.setBool('onBoardingSeen', true);
                    Get.offAllNamed(AppRoutes.login);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  child: Text(
                    'العودة لتسجيل الدخول',
                    style: cairoStyle(fontcolor: Colors.white, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
