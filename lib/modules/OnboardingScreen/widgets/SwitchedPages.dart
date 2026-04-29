import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:hrx/data/static/onboardingmodels.dart';
import 'package:hrx/modules/OnboardingScreen/controllers/onboardingController.dart';
import 'package:hrx/modules/OnboardingScreen/widgets/onboardingItem.dart';

class Switchedpages extends StatelessWidget {
  const Switchedpages({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GetBuilder<OnboardingController>(
        builder: (controller) => PageView.builder(
          controller: controller.pageController,
          onPageChanged: controller.changePage,
          itemCount: pages.length,
          itemBuilder: (context, index) {
            return Onboardingitem(model: pages[index]);
          },
        ),
      ),
    );
  }
}
