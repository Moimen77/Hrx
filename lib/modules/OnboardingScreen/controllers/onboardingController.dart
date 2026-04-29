import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/services/myServices.dart';
import 'package:hrx/data/static/onboardingmodels.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  var currentIndex = 0.obs;
  final prefs = Get.find<Myservices>().sharedPref;
  void changePage(int index) {
    currentIndex.value = index;
    update();
  }

  void next() {
    if (currentIndex.value < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      finish();
    }
  }

  void finish() {
    prefs.setBool("onBoardingSeen", true);
    Get.offAllNamed("/login"); // روح للّوجن
  }
}
