import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/controller/PermissionRequestController.dart';
import 'package:hrx/modules/Employee/Manager_Leave_Reponse/widget/PermissionPageForm.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class PermissionRequestView extends GetView<PermissionRequestController> {
  const PermissionRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FA),
      appBar: CustomAppBar(title: 'طلب الإذن'),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Obx(() {
          if (!controller.networkController.isConnected.value) {
            return NoInternetWidget(
              onPressed: () async {
                await controller.fetchEmployees();
              },
            );
          }
          if (controller.isDataLoading.value) {
            return const Center(
              child: CircularProgressIndicator(color: Appcolors.primarycolor),
            );
          }

          return const PermissionPageForm();
        }),
      ),
    );
  }
}
