import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/HomePage/controller/HomePageController.dart';
import 'package:hrx/routes/app_pages.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class RegisterAttendanceButton extends GetView<Homepagecontroller> {
  const RegisterAttendanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => (controller.isCheckedIn && controller.isCheckedOut)
          ? const SizedBox.shrink()
          : Buttonapp(
              OnTap: () {
                controller.isCheckedIn
                    ? controller.CheckOut(context)
                    : Get.toNamed(AppRoutes.checkInOut);
              },
              text: controller.isCheckedIn ? 'تسجيل الانصراف' : 'تسجيل الحضور',
              Loadingtext: controller.isCheckedIn
                  ? 'جاري تسجيل الانصراف...'
                  : 'جاري تسجيل الحضور...',
              isloading: controller.isCheckoutloading.value,
            ),
    );
  }
}
