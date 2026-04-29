import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';

class Imagelogin extends StatelessWidget {
  const Imagelogin({super.key});

  @override
  Widget build(BuildContext context) {
    double height = Responsive.isMobile(context) ? 220.h : 350.h;
    return Center(
      child: SizedBox(
        height: height,
        width: Get.width * 0.55,
        child: Image.asset(
          "resources/assets/images/login.webp",
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
