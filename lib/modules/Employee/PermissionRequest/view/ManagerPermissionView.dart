import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hrx/core/class/ResponsiveClass.dart';
import 'package:hrx/core/class/spAdabt.dart';
import 'package:hrx/core/constant/TextStyleConst.dart';
import 'package:hrx/modules/Employee/PermissionRequest/controller/ManagerPermissionController.dart';
import 'package:hrx/modules/Employee/PermissionRequest/widget/ListPermissionsCard.dart';
import 'package:hrx/shared_widgets/NoInternetWidget.dart';
import 'package:hrx/shared_widgets/customAppPar.dart';

class ManagerPermissionView extends GetView<ManagerPermissionController> {
  const ManagerPermissionView({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final isTablet = Responsive.isTablet(context);

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
              style: cairoStyle(
                fontSize: 16.spAdaptive(context),
                fontcolor: Colors.grey,
              ),
            ),
          );
        }
        return Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isDesktop
                  ? 1040
                  : isTablet
                  ? 900
                  : double.infinity,
            ),
            child: Padding(
              padding: EdgeInsets.all(
                isDesktop ? 24.spAdaptive(context) : 16.spAdaptive(context),
              ),
              child: const ListPermissionsCard(),
            ),
          ),
        );
      }),
    );
  }
}
