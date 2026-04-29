import 'package:get/get.dart';
import 'package:hrx/modules/OnboardingScreen/controllers/onboardingController.dart';

class OnboardingBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OnboardingController>(() => OnboardingController());
  }
}
