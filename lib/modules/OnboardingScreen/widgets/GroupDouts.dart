import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/data/static/onboardingmodels.dart';
import 'package:hrx/modules/OnboardingScreen/controllers/onboardingController.dart';
import 'package:hrx/modules/OnboardingScreen/widgets/DoutsOnBoarding.dart';

class Groupdouts extends StatelessWidget {
  const Groupdouts({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      builder: (controller) => Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(pages.length, (index) {
          return Doutsonboarding(
            isactive: controller.currentIndex.value == index,
          );
        }),
      ),
    );
  }
}
