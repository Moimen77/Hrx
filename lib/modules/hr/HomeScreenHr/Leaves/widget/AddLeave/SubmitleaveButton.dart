import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/modules/hr/HomeScreenHr/Leaves/controller/AddLeaveController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class SubmitLeaveButton extends GetView<AddLeaveController> {
  const SubmitLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Buttonapp(
          OnTap: () {
            controller.submitLeave(context);
          },
          width: Responsive.isDesktop(context)
              ? 430
              : Responsive.isTablet(context)
              ? Get.width * 0.6
              : Get.width * 0.8,
          isloading: controller.isSubmitloading.value,
          text: 'تسجيل الأجازة',
          Loadingtext: 'يتم تسجيل الأجازة...',
        ),
      ),
    );
  }
}
