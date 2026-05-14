// Improved UI styling with borders & more icons without changing logic
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/appColors.dart';
import 'package:hrx/modules/Employee/Leaves/controller/RequestLeaveController.dart';
import 'package:hrx/modules/Employee/Leaves/widget/LeavePageForm.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class LeaveRequestView extends GetView<LeaveController> {
  const LeaveRequestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'طلب إجازة'),
      body: Obx(() {
        // if (!controller.networkController.isConnected.value) {
        //   return NoInternetWidget(
        //     onPressed: () async {
        //       await controller.loadInitialData();
        //     },
        //   );
        // }
        if (controller.isDataLoading.value) {
          return Center(
            child: CircularProgressIndicator(color: Appcolors.primarycolor),
          );
        }
        return LeavePageForm();
      }),
    );
  }
}
