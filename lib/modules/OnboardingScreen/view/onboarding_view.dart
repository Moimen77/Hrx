import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/OnboardingScreen/widgets/GroupDouts.dart';
import 'package:hrx/modules/OnboardingScreen/widgets/SkipTextButton.dart';
import 'package:hrx/modules/OnboardingScreen/widgets/SwitchedPages.dart';
import 'package:hrx/modules/OnboardingScreen/widgets/onboardingButton.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
          child: Column(
            children: [
              Skiptextbutton(),
              Gap(Get.height * 0.05),
              Switchedpages(),
              Gap(Get.height * 0.05),
              Groupdouts(),
              Gap(Get.height * 0.05),
              Onboardingbutton(text: 'التالي'),
            ],
          ),
        ),
      ),
    );
  }
}
