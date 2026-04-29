import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Department/view/add_department_controller.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class ButtonAddDepartment extends GetView<AddDepartmentController> {
  const ButtonAddDepartment({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Center(
        child: Buttonapp(
          OnTap: () {
            controller.saveDepartment(context);
          },
          width: Get.width * 0.85,
          isloading: controller.isLoading.value,
          text: 'حفظ القسم',
          Loadingtext: 'جار حفظ القسم... ',
        ),
      ),
    );
  }
}
