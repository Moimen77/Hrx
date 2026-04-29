import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/data/models/onboarding_model.dart';
import 'package:get/get.dart';

class Onboardingitem extends StatelessWidget {
  const Onboardingitem({super.key, required this.model});
  final OnboardingModel model;

  @override
  Widget build(BuildContext context) {
    final h = Get.height;
    final w = Get.width;
    return Column(
      children: [
        SizedBox(
          height: h * 0.30,
          width: w * 0.8,
          child: Image.asset(model.image, fit: BoxFit.contain),
        ),
        Gap(h * 0.05),
        Text(
          model.title,
          style: cairoStyle(fontSize: w * 0.06, fontweight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        Gap(h * 0.015),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.05),
          child: Text(
            model.description,
            style: cairoStyle(fontweight: FontWeight.w300),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
