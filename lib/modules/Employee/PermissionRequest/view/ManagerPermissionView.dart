import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/PermissionRequest/controller/ManagerPermissionController.dart';
import 'package:hrx/modules/Employee/PermissionRequest/widget/ListPermissionsCard.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ManagerPermissionView extends GetView<ManagerPermissionController> {
  const ManagerPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: 'طلبات الاستئذان'),
      body: Obx(() {
        if (!controller.networkController.isConnected.value) {
          return NoInternetWidget(
            onPressed: () async {
              await controller.fetchPermissions();
            },
          );
        }
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.permissionsList.isEmpty) {
          return Center(
            child: Text(
              'لا توجد طلبات معلقة حالياً',
              style: cairoStyle(fontSize: 16, fontcolor: Colors.grey),
            ),
          );
        }
        return ListPermissionsCard();
      }),
    );
  }
}
