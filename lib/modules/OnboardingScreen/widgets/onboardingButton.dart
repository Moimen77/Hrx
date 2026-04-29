import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/OnboardingScreen/controllers/onboardingController.dart';

class Onboardingbutton extends GetView<OnboardingController> {
  const Onboardingbutton({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Get.height * 0.05),
      child: InkWell(
        onTap: () {
          controller.next();
        },
        child: Container(
          alignment: Alignment.center,
          width: Get.width * 0.7,
          height: Get.height * 0.06,
          decoration: BoxDecoration(
            color: Appcolors.primarycolor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            'التالي',
            textAlign: TextAlign.center,
            style: cairoStyle(
              fontcolor: Colors.white,
              fontweight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
