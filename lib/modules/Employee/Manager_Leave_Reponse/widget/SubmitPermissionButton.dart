import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';

class SubmitPermissionButton extends GetView<PermissionRequestController> {
  const SubmitPermissionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Obx(
        () => ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.submitRequest,
          style: ElevatedButton.styleFrom(
            backgroundColor: Appcolors.primarycolor,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(14),
            ),
            elevation: 2,
            shadowColor: Appcolors.primarycolor.withOpacity(0.4),
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  'إرسال الطلب',
                  style: cairoStyle(
                    fontSize: 18,
                    fontweight: FontWeight.bold,
                    fontcolor: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
