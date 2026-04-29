import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/shared_widgets/ButtonApp.dart';

class RequestLeaveButton extends GetView<LeaveController> {
  const RequestLeaveButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Buttonapp(
        OnTap: () {
          controller.submitLeave(controller.employeeId!, context);
        },
        text: 'ارسال الطلب',
        Loadingtext: 'جاري ارسال الطلب...',
        isloading: controller.isLoading.value,
      ),
    );
  }
}
