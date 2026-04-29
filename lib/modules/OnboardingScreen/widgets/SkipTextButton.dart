import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/OnboardingScreen/controllers/onboardingController.dart';

class Skiptextbutton extends GetView<OnboardingController> {
  const Skiptextbutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: TextButton(
        child: Text(
          'تخطي',
          style: cairoStyle(fontcolor: Appcolors.primarycolor),
        ),
        onPressed: () {
          controller.finish();
        },
      ),
    );
  }
}
